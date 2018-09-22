Class {
	#name : #BabylonOpenGLDriver,
	#superclass : #BabylonDriver,
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
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #initialization }
BabylonOpenGLDriver class >> initialize [
	PrimitiveTypeMap := Dictionary newFromPairs: { 
		BabylonSubmesh2D points . GL_POINTS .
		BabylonSubmesh2D lines . GL_LINES .
		BabylonSubmesh2D triangles . GL_TRIANGLES .
	}.
	
	PositionBinding := 0.
	ColorBinding := 1.
	TexcoordBinding := 2.
]

{ #category : #testing }
BabylonOpenGLDriver class >> isSuitable [
	^ false
]

{ #category : #testing }
BabylonOpenGLDriver class >> isSupported [
	^ false
]

{ #category : #compiling }
BabylonOpenGLDriver class >> noteCompilationOf: aSelector meta: isMeta [
	self methodDict at: aSelector ifPresent: [ :method |
		(method hasPragmaNamed: #shader) ifTrue: [
			self allInstancesDo: #flushShaders
		]
	]
]

{ #category : #accessing }
BabylonOpenGLDriver >> colorBinding [
	^ ColorBinding
]

{ #category : #shaders }
BabylonOpenGLDriver >> colorFragmentSource [
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
BabylonOpenGLDriver >> colorProgram [
	mutex critical: [ 
		^ colorProgram ifNil: [ colorProgram := self programWithVertexSource: self vertexSource fragmentSource: self colorFragmentSource ]
	]

]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> compileFragmentShader: source [
	^ self compileShader: source type: GL_FRAGMENT_SHADER
]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> compileShader: source type: type [
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
BabylonOpenGLDriver >> compileVertexShader: source [
	^ self compileShader: source type: GL_VERTEX_SHADER
]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> context [
	mutex critical: [ 
		^ context ifNil: [ context := UFFIOpenGLContext new ]
	]

]

{ #category : #'shape convertion' }
BabylonOpenGLDriver >> convertMaterial: aMaterial [
	self flag: 'Implement myself'.
	^ aMaterial
]

{ #category : #'shape convertion' }
BabylonOpenGLDriver >> convertMesh2D: aPompeiiMesh [
	| vertices indices indexCount glSubmesh submeshes |
	vertices := UFFIOpenGLGrowableBuffer new.
	indices := UFFIOpenGLGrowableBuffer new.
	aPompeiiMesh vertices do: [ :vertex | vertex putIntoOpenGLGrowableBuffer: vertices ].
	indexCount := 0.
	submeshes := aPompeiiMesh submeshes collect: [ :submesh |
		submesh indices do: [ :index |
			indices putUInt32: index
		].
		glSubmesh := BabylonOpenGLSubmesh new
			startIndex: indexCount;
			indexCount: submesh indices size;
			primitiveType: (self mapPrimitiveType: submesh primitiveType);
			material: (self convertMaterial: submesh material);
			yourself.
		indexCount := indexCount + glSubmesh indexCount.
		glSubmesh
	].

	^ BabylonOpenGLMesh2D new
		vertices: vertices data;
		indices: indices data;
		submeshes: submeshes;
		yourself
]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> createFontCache: aLogicalFont [
	^ BabylonOpenGLFontCache for: aLogicalFont
]

{ #category : #shaders }
BabylonOpenGLDriver >> flushShaders [
	colorProgram := nil.
	textProgram := nil.
]

{ #category : #'shape convertion' }
BabylonOpenGLDriver >> mapPrimitiveType: primitiveType [
	^ PrimitiveTypeMap at: primitiveType
]

{ #category : #accessing }
BabylonOpenGLDriver >> positionBinding [
	^ PositionBinding
]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> programWithVertexSource: vertexSource fragmentSource: fragmentSource [
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
BabylonOpenGLDriver >> setupOSWindowAttributes: attributes [
	attributes glAttributes: UFFIOpenGLContext glAttributes
]

{ #category : #'instance creation' }
BabylonOpenGLDriver >> surfaceWithExtent: anExtent [
	^ BabylonOpenGLSurface extent: anExtent driver: self
]

{ #category : #accessing }
BabylonOpenGLDriver >> texcoordBinding [
	^ TexcoordBinding
]

{ #category : #shaders }
BabylonOpenGLDriver >> textFragmentSource [
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
BabylonOpenGLDriver >> textProgram [
	mutex critical: [ 
		^ textProgram ifNil: [ textProgram := self programWithVertexSource: self vertexSource fragmentSource: self textFragmentSource ]
	]

]

{ #category : #shaders }
BabylonOpenGLDriver >> vertexSource [
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
