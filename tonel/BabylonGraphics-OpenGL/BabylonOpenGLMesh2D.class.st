Class {
	#name : #BabylonOpenGLMesh2D,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'indices',
		'submeshes'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #converting }
BabylonOpenGLMesh2D >> asBabylonShapeFor: aPompeiiDriver [
	^ self
]

{ #category : #'as yet unclassified' }
BabylonOpenGLMesh2D >> drawWithOpenGLCanvas: aCanvas [
	^ aCanvas drawGLMesh2D: self
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> indices [
	^ indices
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> indices: anObject [
	indices := anObject
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> submeshes [
	^ submeshes
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> submeshes: anObject [
	submeshes := anObject
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> vertices [
	^ vertices
]

{ #category : #accessing }
BabylonOpenGLMesh2D >> vertices: anObject [
	vertices := anObject
]
