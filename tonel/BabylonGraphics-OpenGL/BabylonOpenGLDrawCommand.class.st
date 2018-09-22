Class {
	#name : #BabylonOpenGLDrawCommand,
	#superclass : #BabylonOpenGLCommand,
	#instVars : [
		'mesh',
		'submesh'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #execute }
BabylonOpenGLDrawCommand >> executeWith: gl on: surface [
	| indexPointer |
	surface activateMaterial: submesh material.
	indexPointer := (surface getMeshIndexPointer: mesh) + (submesh startIndex*4).
	
	surface hasBaseVertex ifTrue: [
		gl drawElementsBaseVertex_mode: submesh primitiveType count: submesh indexCount type: GL_UNSIGNED_INT indices: indexPointer basevertex: (surface getMeshBaseVertex: mesh)
	] ifFalse: [
		gl drawElements_mode: submesh primitiveType count: submesh indexCount type: GL_UNSIGNED_INT indices: indexPointer
	]

]

{ #category : #testing }
BabylonOpenGLDrawCommand >> isDrawCommand [
	^ true
]

{ #category : #accessing }
BabylonOpenGLDrawCommand >> mesh [
	^ mesh
]

{ #category : #accessing }
BabylonOpenGLDrawCommand >> mesh: anObject [
	mesh := anObject
]

{ #category : #accessing }
BabylonOpenGLDrawCommand >> submesh [
	^ submesh
]

{ #category : #accessing }
BabylonOpenGLDrawCommand >> submesh: anObject [
	submesh := anObject
]
