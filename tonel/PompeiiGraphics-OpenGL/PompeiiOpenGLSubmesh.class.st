Class {
	#name : #PompeiiOpenGLSubmesh,
	#superclass : #Object,
	#instVars : [
		'startIndex',
		'indexCount',
		'primitiveType',
		'material'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #accessing }
PompeiiOpenGLSubmesh >> indexCount [
	^ indexCount
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> indexCount: anObject [
	indexCount := anObject
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> material [
	^ material
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> material: anObject [
	material := anObject
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> primitiveType [
	^ primitiveType
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> primitiveType: anObject [
	primitiveType := anObject
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> startIndex [
	^ startIndex
]

{ #category : #accessing }
PompeiiOpenGLSubmesh >> startIndex: anInteger [
	startIndex := anInteger
]
