Class {
	#name : #PompeiiOpenGLMeshMemoryMap,
	#superclass : #PompeiiSurface,
	#instVars : [
		'baseVertex',
		'baseIndex'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #accessing }
PompeiiOpenGLMeshMemoryMap >> baseIndex [
	^ baseIndex
]

{ #category : #accessing }
PompeiiOpenGLMeshMemoryMap >> baseIndex: anObject [
	baseIndex := anObject
]

{ #category : #accessing }
PompeiiOpenGLMeshMemoryMap >> baseVertex [
	^ baseVertex
]

{ #category : #accessing }
PompeiiOpenGLMeshMemoryMap >> baseVertex: anObject [
	baseVertex := anObject
]
