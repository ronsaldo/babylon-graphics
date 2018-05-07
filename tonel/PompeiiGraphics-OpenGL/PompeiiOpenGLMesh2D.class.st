Class {
	#name : #PompeiiOpenGLMesh2D,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'indices',
		'submeshes'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #converting }
PompeiiOpenGLMesh2D >> asPompeiiShapeFor: aPompeiiDriver [
	^ self
]

{ #category : #'as yet unclassified' }
PompeiiOpenGLMesh2D >> drawWithOpenGLCanvas: aCanvas [
	^ aCanvas drawGLMesh2D: self
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> indices [
	^ indices
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> indices: anObject [
	indices := anObject
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> startIndex: anObject [
	startIndex := anObject
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> submeshes [
	^ submeshes
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> submeshes: anObject [
	submeshes := anObject
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> vertices [
	^ vertices
]

{ #category : #accessing }
PompeiiOpenGLMesh2D >> vertices: anObject [
	vertices := anObject
]
