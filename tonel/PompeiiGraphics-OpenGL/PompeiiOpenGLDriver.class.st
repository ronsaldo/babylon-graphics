Class {
	#name : #PompeiiOpenGLDriver,
	#superclass : #PompeiiDriver,
	#instVars : [
		'context',
		'colorProgram',
		'textProgram'
	],
	#classVars : [
		'ColorBinding',
		'PositionBinding',
		'PrimitiveTypeMap',
		'TexcoordBinding'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #initialization }
PompeiiOpenGLDriver class >> initialize [
	PrimitiveTypeMap := Dictionary newFromPairs: { 
		PompeiiSubmesh2D points . GL_POINTS .
		PompeiiSubmesh2D lines . GL_LINES .
		PompeiiSubmesh2D triangles . GL_TRIANGLES .
	}.
	
	PositionBinding := 0.
	ColorBinding := 1.
	TexcoordBinding := 2.
]

{ #category : #testing }
PompeiiOpenGLDriver class >> isSuitable [
	^ true
]

{ #category : #testing }
PompeiiOpenGLDriver class >> isSupported [
	^ true
]

{ #category : #compiling }
PompeiiOpenGLDriver class >> noteCompilationOf: aSelector meta: isMeta [
	self methodDict at: aSelector ifPresent: [ :method |
		(method hasPragmaNamed: #shader) ifTrue: [
			self allInstancesDo: #flushShaders
		]
	]
]

{ #category : #accessing }
PompeiiOpenGLDriver >> colorBinding [
	^ ColorBinding
]

{ #category : #shaders }
PompeiiOpenGLDriver >> colorFragmentSource [
	<shader>
	^ '
#version 120

varying vec4 fColor;

void main()
{
	gl_FragData[0] = fColor;
}
'
]

{ #category : #shaders }
PompeiiOpenGLDriver >> colorProgram [
	mutex critical: [ 
		^ colorProgram ifNil: [ colorProgram := self programWithVertexSource: self vertexSource fragmentSource: self colorFragmentSource ]
	]

]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> compileFragmentShader: source [
	^ self compileShader: source type: GL_FRAGMENT_SHADER
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> compileShader: source type: type [
	| gl shader compilationError |
	gl := self context gl.
	self context asCurrentDo: [
		shader := context shader: type.
		shader source: (source copyReplaceAll: String cr with: String lf);
			compile.
			
		shader compileStatus ifFalse: [
			compilationError := shader infoLog.
			Transcript show: compilationError; cr.
			self error: 'Shader compilation failed:' , String cr , compilationError
		].
	] ifFailure: [ 
		self error: 'Failed to create the shader object'.
	].

	^ shader
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> compileVertexShader: source [
	^ self compileShader: source type: GL_VERTEX_SHADER
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> context [
	mutex critical: [ 
		^ context ifNil: [ context := UFFIOpenGLContext new ]
	]

]

{ #category : #'shape convertion' }
PompeiiOpenGLDriver >> convertMaterial: aMaterial [
	self flag: 'Implement myself'.
	^ aMaterial
]

{ #category : #'shape convertion' }
PompeiiOpenGLDriver >> convertMesh2D: aPompeiiMesh [
	| vertices indices indexCount glSubmesh submeshes |
	vertices := UFFIOpenGLGrowableBuffer new.
	indices := UFFIOpenGLGrowableBuffer new.
	aPompeiiMesh vertices do: [ :vertex | vertex putIntoOpenGLGrowableBuffer: vertices ].
	indexCount := 0.
	submeshes := aPompeiiMesh submeshes collect: [ :submesh |
		submesh indices do: [ :index |
			indices putUInt32: index
		].
		glSubmesh := PompeiiOpenGLSubmesh new
			startIndex: indexCount;
			indexCount: submesh indices size;
			primitiveType: (self mapPrimitiveType: submesh primitiveType);
			material: (self convertMaterial: submesh material);
			yourself.
		indexCount := indexCount + glSubmesh indexCount.
		glSubmesh
	].

	^ PompeiiOpenGLMesh2D new
		vertices: vertices data;
		indices: indices data;
		submeshes: submeshes;
		yourself
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> createFontCache: aLogicalFont [
	^ PompeiiOpenGLFontCache for: aLogicalFont
]

{ #category : #shaders }
PompeiiOpenGLDriver >> flushShaders [
	colorProgram := nil.
	textProgram := nil.
]

{ #category : #'shape convertion' }
PompeiiOpenGLDriver >> mapPrimitiveType: primitiveType [
	^ PrimitiveTypeMap at: primitiveType
]

{ #category : #accessing }
PompeiiOpenGLDriver >> positionBinding [
	^ PositionBinding
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> programWithVertexSource: vertexSource fragmentSource: fragmentSource [
	| vertexShader fragmentShader program linkError |
	vertexShader := self compileVertexShader: vertexSource.
	fragmentShader := self compileFragmentShader: fragmentSource.
	program := context program.
	context asCurrentDo: [ 
		program
			attach: vertexShader;
			attach: fragmentShader;
			bindAttribute: 'vPosition' location: PositionBinding;
			bindAttribute: 'vColor' location: ColorBinding;
			bindAttribute: 'vTexcoord' location: TexcoordBinding;
			link.
		program linkStatus ifFalse: [
			linkError := program infoLog.
			Transcript show: linkError; cr.
			self error: 'Failed to link a GPU program:' , String cr , linkError
		]
	] ifFailure: [
		self error: 'Failed to build the GPU program.'
	].

	^ program
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLDriver >> setupOSWindowAttributes: attributes [
	attributes glAttributes: UFFIOpenGLContext glAttributes
]

{ #category : #'instance creation' }
PompeiiOpenGLDriver >> surfaceWithExtent: anExtent [
	^ PompeiiOpenGLSurface extent: anExtent driver: self
]

{ #category : #accessing }
PompeiiOpenGLDriver >> texcoordBinding [
	^ TexcoordBinding
]

{ #category : #shaders }
PompeiiOpenGLDriver >> textFragmentSource [
	<shader>
	^ '
#version 120

uniform sampler2D fontTexture;
uniform vec2 fontTextureInvertedSize;

varying vec2 fTexcoord;
varying vec4 fColor;

void main()
{
	gl_FragData[0] = vec4(fColor.rgb, fColor.a*texture2D(fontTexture, fontTextureInvertedSize*fTexcoord).r);
}
'
]

{ #category : #shaders }
PompeiiOpenGLDriver >> textProgram [
	mutex critical: [ 
		^ textProgram ifNil: [ textProgram := self programWithVertexSource: self vertexSource fragmentSource: self textFragmentSource ]
	]

]

{ #category : #shaders }
PompeiiOpenGLDriver >> vertexSource [
	<shader>
	^ '
#version 120

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

attribute vec2 vPosition;
attribute vec2 vTexcoord;
attribute vec4 vColor;

varying vec3 fPosition;
varying vec2 fTexcoord;
varying vec4 fColor;

void main()
{
	vec4 viewPosition = modelViewMatrix * vec4(vPosition, 0.0, 1.0);
	fPosition = viewPosition.xyz;
	
	fTexcoord = vTexcoord;
	fColor = vColor;
	gl_Position = projectionMatrix * viewPosition;
}
'
]
