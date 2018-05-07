Class {
	#name : #PompeiiOpenGLSurface,
	#superclass : #PompeiiSurface,
	#instVars : [
		'context',
		'surface',
		'gl',
		'driver',
		'meshesInMemory',
		'meshesToSend',
		'drawingCommands',
		'meshMemoryMap',
		'vertexBufferCapacity',
		'indexBufferCapacity',
		'vertexBuffer',
		'indexBuffer',
		'hasBaseVertex',
		'projectionMatrixData',
		'modelViewMatrixData',
		'currentProgram',
		'transform',
		'currentTransform',
		'activeMaterial',
		'flipY'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #'as yet unclassified' }
PompeiiOpenGLSurface class >> defaultSampleCount [
	^ 4
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLSurface class >> extent: anExtent driver: driver [
	^ self new initializeWithExtent: anExtent driver: driver
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLSurface class >> extent: anExtent driver: driver sampleCount: sampleCount [
	^ self new initializeWithExtent: anExtent driver: driver sampleCount: sampleCount
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> activateMaterial: aMaterial [
	activeMaterial == aMaterial ifTrue: [ ^ self ].
	
	aMaterial ifNil: [
		self activateNullMaterial
	] ifNotNil: [
		aMaterial activateMaterialIn: self
	].
	activeMaterial := aMaterial.
	
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> activateNullMaterial [
	self useProgram: driver colorProgram.
	activeMaterial := nil.
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> addCommand: aCommand [
	drawingCommands add: aCommand
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> addDrawingCommandMesh: mesh submesh: submesh [
	self flushTransforms.
	meshesToSend add: mesh.
	drawingCommands add: (PompeiiOpenGLDrawCommand new
		mesh: mesh;
		submesh: submesh;
		yourself)
]

{ #category : #converting }
PompeiiOpenGLSurface >> asForm [
	^ surface asForm
]

{ #category : #drawing }
PompeiiOpenGLSurface >> blitIntoOSWindow: anOSWindow [
	context withWindow: anOSWindow validHandle do: [
		surface blitToMainFramebuffer.
		
		context swapBuffers: anOSWindow validHandle.
		context checkErrors
	] ifFailure: [
		self error: 'Failed to blit into window.'
	].

]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> clearPendingCommands [
	meshesToSend removeAll.
	drawingCommands removeAll.

]

{ #category : #accessing }
PompeiiOpenGLSurface >> context [
	^ context
]

{ #category : #drawing }
PompeiiOpenGLSurface >> doDrawBlock: aBlock [
	| canvas |
	self setSurfaceState.
	canvas := PompeiiOpenGLCanvas new
		surface: self;
		yourself.
	aBlock value: canvas.
	self submitDrawingCommands
]

{ #category : #drawing }
PompeiiOpenGLSurface >> drawDuring: aBlock [
	driver critical: [ 
		flipY := true.
		context asCurrentDo: [
			self doDrawBlock: aBlock
		]
	]

]

{ #category : #drawing }
PompeiiOpenGLSurface >> drawToOSWindow: anOSWindow during: aBlock [
	driver critical: [ 
		flipY := false.
		context asCurrentDo: [
			self doDrawBlock: aBlock.
		].

		self blitIntoOSWindow: anOSWindow
	]

]

{ #category : #accessing }
PompeiiOpenGLSurface >> driver [
	^ driver
]

{ #category : #matrices }
PompeiiOpenGLSurface >> encodeFloatArray: anArray [
	| result destIndex |
	result := ByteArray new: anArray size * 4.
	destIndex := 1.
	anArray do: [ :x |
		result floatAt: destIndex put: x.
		destIndex := destIndex + 4
	].
	^ result
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> ensureIndexBufferCapacity: requiredSize [
	| newCapacity |
	(indexBuffer isNotNil and: [ requiredSize <= indexBufferCapacity ]) ifTrue: [ ^ self ].

	"Ensure the index buffer exists."
	indexBuffer ifNil: [ indexBuffer := context bufferObject ].

	"Compute the capacity"
	newCapacity := 1 << requiredSize highBit max: 256.
	self assert: newCapacity >= requiredSize.	
	indexBufferCapacity := indexBufferCapacity max: newCapacity.

	gl
		bindBuffer_target: GL_ELEMENT_ARRAY_BUFFER buffer: indexBuffer handle;
		bufferData_target: GL_ELEMENT_ARRAY_BUFFER size: indexBufferCapacity data: nil usage: GL_STREAM_DRAW
	
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> ensureVertexBufferCapacity: requiredSize [
	| newCapacity |
	(vertexBuffer isNotNil and: [ requiredSize <= vertexBufferCapacity ]) ifTrue: [ ^ self ].

	"Ensure the vertex buffer exists."
	vertexBuffer ifNil: [ vertexBuffer := context bufferObject ].

	"Compute the capacity"
	newCapacity := 1 << requiredSize highBit max: 256.
	self assert: newCapacity >= requiredSize.	
	vertexBufferCapacity := vertexBufferCapacity max: newCapacity.
	gl
		bindBuffer_target: GL_ARRAY_BUFFER buffer: vertexBuffer handle;
		bufferData_target: GL_ARRAY_BUFFER size: vertexBufferCapacity data: nil usage: GL_STREAM_DRAW
	
]

{ #category : #accessing }
PompeiiOpenGLSurface >> extent [
	^ surface extent
]

{ #category : #accessing }
PompeiiOpenGLSurface >> extent: anExtent [
	surface extent: anExtent
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> flushTransforms [
	currentTransform ~= transform ifTrue: [
		self addCommand: (PompeiiOpenGLSetModelViewCommand new matrix: (self encodeFloatArray: transform asFloatMatrix4)).
		currentTransform := transform copy.
	]
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> getMeshBaseVertex: mesh [
	^ (meshMemoryMap at: mesh) baseVertex
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> getMeshIndexPointer: mesh [
	^ ExternalAddress fromAddress: (meshMemoryMap at: mesh) baseIndex
]

{ #category : #accessing }
PompeiiOpenGLSurface >> gl [
	^ gl
]

{ #category : #testing }
PompeiiOpenGLSurface >> hasBaseVertex [
	^ hasBaseVertex
]

{ #category : #matrices }
PompeiiOpenGLSurface >> identityMatrixData [
	^ self encodeFloatArray: {
		1.0 . 0.0 . 0.0 . 0.0 .
		0.0 . 1.0 . 0.0 . 0.0 .
		0.0 . 0.0 . 1.0 . 0.0 .
		0.0 . 0.0 . 0.0 . 1.0 .
	}
]

{ #category : #initialization }
PompeiiOpenGLSurface >> initializeCommonState [
	transform := PompeiiGenericTransform new.
	
	hasBaseVertex := context isAtLeastGL32.
	
	meshesInMemory := IdentitySet new.
	meshesToSend := IdentitySet new.
	drawingCommands := OrderedCollection new.
	meshMemoryMap := IdentityDictionary new.
	
	vertexBufferCapacity := 0.
	vertexBuffer := nil.
	indexBufferCapacity := 0.
	indexBuffer := nil
]

{ #category : #initialization }
PompeiiOpenGLSurface >> initializeWithExtent: anExtent context: anOpenGLContext [
	^ self initializeWithExtent: anExtent context: anOpenGLContext sampleCount: self class defaultSampleCount
]

{ #category : #initialization }
PompeiiOpenGLSurface >> initializeWithExtent: anExtent context: anOpenGLContext sampleCount: aSampleCount [
	context := anOpenGLContext.
	gl := context gl.
	surface := context offscreenBufferExtent: anExtent sampleCount: aSampleCount.
	self initializeCommonState.
]

{ #category : #initialization }
PompeiiOpenGLSurface >> initializeWithExtent: anExtent driver: aDriver [
	^ self initializeWithExtent: anExtent driver: aDriver sampleCount: self class defaultSampleCount
]

{ #category : #initialization }
PompeiiOpenGLSurface >> initializeWithExtent: anExtent driver: aDriver sampleCount: aSampleCount [
	driver := aDriver.
	context := aDriver context.
	gl := context gl.
	surface := context offscreenBufferExtent: anExtent sampleCount: aSampleCount.
	self initializeCommonState.
]

{ #category : #matrices }
PompeiiOpenGLSurface >> modelViewMatrix: theModelViewMatrixData [
	modelViewMatrixData := theModelViewMatrixData.
	currentProgram ifNotNil: [ 
		currentProgram uniform: #modelViewMatrix transposedMatrix4: modelViewMatrixData.
	]

]

{ #category : #matrices }
PompeiiOpenGLSurface >> orthoLeft: left right: right bottom: bottom top: top near: near far: far [
	| tx ty tz |
	tx := (right + left) / (right - left) negated.
	ty := (top + bottom) / (top - bottom) negated.
	tz := (far + near) / (far - near) negated.
	
	^ self encodeFloatArray: {
		2.0 / (right - left) . 0.0 . 0.0 . tx .
		0.0 . 2.0 / (top - bottom) . 0.0 . ty .
		0.0 . 0.0 . -2.0 / (far - near) . tz .
		0.0 . 0.0 . 0.0 . 1.0
	}
]

{ #category : #matrices }
PompeiiOpenGLSurface >> projectionMatrix: theProjectionMatrixData [
	projectionMatrixData := theProjectionMatrixData.
	currentProgram ifNotNil: [ 
		currentProgram uniform: #projectionMatrix transposedMatrix4: projectionMatrixData.
	]

]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> sendMeshesToMemory [
	| tmp vertexBufferSize indexBufferSize vertexMemory indexMemory nextVertexOffset nextIndexOffset map |
	"Swap the mesh sets."
	tmp := meshesInMemory.
	meshesInMemory := meshesToSend.
	meshesToSend := tmp.
	
	meshMemoryMap removeAll.

	"Compute the total memory requirement."	
	vertexBufferSize := 0.
	indexBufferSize := 0.
	meshesInMemory do: [ :mesh |
		vertexBufferSize := vertexBufferSize + mesh vertices size.
		indexBufferSize := indexBufferSize + mesh indices size.
	].

	self ensureVertexBufferCapacity: vertexBufferSize.
	self ensureIndexBufferCapacity: indexBufferSize.
	
	gl
		bindBuffer_target: GL_ARRAY_BUFFER buffer: vertexBuffer handle;
		bindBuffer_target: GL_ELEMENT_ARRAY_BUFFER buffer: indexBuffer handle.
	
	nextVertexOffset := 0.
	nextIndexOffset := 0.
	vertexMemory := gl mapBuffer_target: GL_ARRAY_BUFFER access: GL_WRITE_ONLY.
	(vertexMemory isNil or: [ vertexMemory isNull ]) ifTrue: [ self error: 'Failed to map vertex buffer.' ].
		
	[ 
		indexMemory := gl mapBuffer_target: GL_ELEMENT_ARRAY_BUFFER access: GL_WRITE_ONLY.
		(indexMemory isNil or: [ indexMemory isNull ]) ifTrue: [ self error: 'Failed to map index buffer.' ].
		[
			meshesInMemory do: [ :mesh |
				self assert: mesh vertices size % PompeiiMesh2DVertex structureSize = 0.
				map := PompeiiOpenGLMeshMemoryMap new
					baseVertex: nextVertexOffset / PompeiiMesh2DVertex structureSize;
					baseIndex: nextIndexOffset;
					yourself.
				meshMemoryMap at: mesh put: map.
				
				LibC memCopy: mesh vertices to: vertexMemory + nextVertexOffset size: mesh vertices size.
				(hasBaseVertex or: [map baseVertex = 0 ]) ifTrue: [ 
					LibC memCopy: mesh indices to: indexMemory + nextIndexOffset size: mesh indices size.				
				] ifFalse: [
					"We need to remap the indices if we do not have support for a base vertex."
					| dest sourceIndices baseVertex |
					sourceIndices := mesh indices.
					baseVertex := map baseVertex.
					dest := indexMemory getHandle. 
					0 to: sourceIndices size / 4 - 1 do: [ :i |
						| offset |
						offset := i*4 + 1.
						dest unsignedLongAt: nextIndexOffset + offset put: (sourceIndices unsignedLongAt: offset) + baseVertex
					]
				].

				nextVertexOffset := nextVertexOffset + mesh vertices size.
				nextIndexOffset := nextIndexOffset + mesh indices size.
			]
		]	ensure: [ gl unmapBuffer: GL_ELEMENT_ARRAY_BUFFER ]
	] ensure: [ gl unmapBuffer: GL_ARRAY_BUFFER ].
	 
	self assert: nextVertexOffset = vertexBufferSize.
	self assert: nextIndexOffset = indexBufferSize.	
]

{ #category : #initialization }
PompeiiOpenGLSurface >> setSurfaceState [
	surface activate.
	transform loadIdentity.
	currentTransform := transform copy.
	self
		projectionMatrix: (self orthoLeft: 0.0 right: surface width asFloat
		bottom: (flipY ifTrue: [0.0] ifFalse: [ surface height asFloat ])
		top: (flipY ifTrue: [ surface height asFloat ] ifFalse: [ 0.0 ]) near: -1.0 far: 1.0);
		modelViewMatrix: (self identityMatrixData).
		
	gl
		viewport_x: 0 y: 0 width: surface width height: surface height;
		
		disable: GL_DEPTH_TEST;
		enable: GL_BLEND;
		blendFunc_sfactor: GL_SRC_ALPHA dfactor: GL_ONE_MINUS_SRC_ALPHA;
		blendEquation: GL_FUNC_ADD.
		
	self clearPendingCommands
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> submitDrawingCommands [
	meshesToSend  ~= meshesInMemory ifTrue: [
		self sendMeshesToMemory
	].

	(vertexBuffer isNil and: [ indexBuffer isNil ]) ifTrue: [
		self activateNullMaterial.
		drawingCommands do: [ :command |
			command executeWith: gl on: self
		].
		^ self
	].
	
	self activateNullMaterial.
	gl
		bindBuffer_target: GL_ARRAY_BUFFER buffer: vertexBuffer handle;
		bindBuffer_target: GL_ELEMENT_ARRAY_BUFFER buffer: indexBuffer handle;
		
		pushClientAttrib: GL_CLIENT_VERTEX_ARRAY_BIT.

	[ 
		gl
			enableVertexAttribArray: driver positionBinding;
			enableVertexAttribArray: driver colorBinding;
			enableVertexAttribArray: driver texcoordBinding;

			vertexAttribPointer_index: driver positionBinding size: 2 type: GL_FLOAT normalized: false stride: PompeiiMesh2DVertex structureSize pointer: (ExternalAddress fromAddress: PompeiiMesh2DVertex positionOffset);
			vertexAttribPointer_index: driver colorBinding size: 4 type: GL_FLOAT normalized: false stride: PompeiiMesh2DVertex structureSize pointer: (ExternalAddress fromAddress: PompeiiMesh2DVertex colorOffset);
			vertexAttribPointer_index: driver texcoordBinding size: 2 type: GL_FLOAT normalized: false stride: PompeiiMesh2DVertex structureSize pointer: (ExternalAddress fromAddress: PompeiiMesh2DVertex texcoordOffset).

		drawingCommands do: [ :command |
			command executeWith: gl on: self
		]
	] ensure: [ gl popClientAttrib. self useProgram: nil ]

]

{ #category : #accessing }
PompeiiOpenGLSurface >> transform [
	^ transform
]

{ #category : #'drawing commands' }
PompeiiOpenGLSurface >> useProgram: aProgram [
	currentProgram := aProgram.
	currentProgram ifNil: [ ^ self ].
	
	gl
		useProgram: aProgram validHandle.
		
	aProgram
		uniform: #projectionMatrix transposedMatrix4: projectionMatrixData;
		uniform: #modelViewMatrix transposedMatrix4: modelViewMatrixData
		
]
