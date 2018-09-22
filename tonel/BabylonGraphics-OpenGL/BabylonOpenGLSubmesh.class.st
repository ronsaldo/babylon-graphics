Class {
	#name : #BabylonOpenGLSubmesh,
	#superclass : #Object,
	#instVars : [
		'startIndex',
		'indexCount',
		'primitiveType',
		'material'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #accessing }
BabylonOpenGLSubmesh >> indexCount [
	^ indexCount
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> indexCount: anObject [
	indexCount := anObject
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> material [
	^ material
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> material: anObject [
	material := anObject
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> primitiveType [
	^ primitiveType
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> primitiveType: anObject [
	primitiveType := anObject
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> startIndex [
	^ startIndex
]

{ #category : #accessing }
BabylonOpenGLSubmesh >> startIndex: anInteger [
	startIndex := anInteger
]
