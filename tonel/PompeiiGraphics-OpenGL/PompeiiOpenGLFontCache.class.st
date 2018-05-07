Class {
	#name : #PompeiiOpenGLFontCache,
	#superclass : #PompeiiFontCache,
	#instVars : [
		'modified',
		'texture'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #'as yet unclassified' }
PompeiiOpenGLFontCache >> activateMaterialIn: aSurface [
	| context program |
	context := aSurface driver context.
	program := aSurface driver textProgram.
	aSurface useProgram: program.
	program
		uniform: #fontTexture int: 0;
		uniform: #fontTextureInvertedSize float: self width asFloat reciprocal float: self height asFloat reciprocal.
		
	context gl
		activeTexture: GL_TEXTURE0;
		bindTexture_target: GL_TEXTURE_2D texture: (self textureFor: context) validHandle
	
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLFontCache >> forPompeiiDriver: aDriver [
	^ self
]

{ #category : #initialization }
PompeiiOpenGLFontCache >> initialize [
	super initialize.
	modified := true.
	texture := nil.
]

{ #category : #accessing }
PompeiiOpenGLFontCache >> modified [
	modified := true
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLFontCache >> textureFor: context [
	(texture isNotNil and: [ modified not ]) ifTrue: [ ^ texture ].
	
	self ensureLatin1.
	context asCurrentDo: [
		texture ifNil: [ texture := context textureObject ].
		context gl
			bindTexture_target: GL_TEXTURE_2D texture: texture validHandle;
			texImage2D_target: GL_TEXTURE_2D level: 0 internalformat: GL_LUMINANCE width: self width height: self height border: 0 format: GL_LUMINANCE type: GL_UNSIGNED_BYTE pixels: bits;
			texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_MIN_FILTER param: GL_LINEAR;
			texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_MAG_FILTER param: GL_LINEAR;
			texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_WRAP_S param: GL_CLAMP_TO_EDGE;
			texParameteri_target: GL_TEXTURE_2D pname: GL_TEXTURE_WRAP_T param: GL_CLAMP_TO_EDGE.

	] ifFailure: [ self error: 'Failed to create the font texture.' ].
	modified := false.
	^ texture
]
