Class {
	#name : #PompeiiOpenGLDrawCommand,
	#superclass : #PompeiiOpenGLCommand,
	#instVars : [
		'mesh',
		'submesh'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #execute }
PompeiiOpenGLDrawCommand >> executeWith: gl on: surface [
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
PompeiiOpenGLDrawCommand >> isDrawCommand [
	^ true
]

{ #category : #accessing }
PompeiiOpenGLDrawCommand >> mesh [
	^ mesh
]

{ #category : #accessing }
PompeiiOpenGLDrawCommand >> mesh: anObject [
	mesh := anObject
]

{ #category : #accessing }
PompeiiOpenGLDrawCommand >> submesh [
	^ submesh
]

{ #category : #accessing }
PompeiiOpenGLDrawCommand >> submesh: anObject [
	submesh := anObject
]
