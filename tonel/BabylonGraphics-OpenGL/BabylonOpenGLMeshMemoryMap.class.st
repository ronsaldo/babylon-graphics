Class {
	#name : #BabylonOpenGLMeshMemoryMap,
	#superclass : #BabylonSurface,
	#instVars : [
		'baseVertex',
		'baseIndex'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #accessing }
BabylonOpenGLMeshMemoryMap >> baseIndex [
	^ baseIndex
]

{ #category : #accessing }
BabylonOpenGLMeshMemoryMap >> baseIndex: anObject [
	baseIndex := anObject
]

{ #category : #accessing }
BabylonOpenGLMeshMemoryMap >> baseVertex [
	^ baseVertex
]

{ #category : #accessing }
BabylonOpenGLMeshMemoryMap >> baseVertex: anObject [
	baseVertex := anObject
]
