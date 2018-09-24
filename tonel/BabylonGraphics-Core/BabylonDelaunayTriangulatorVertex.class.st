Class {
	#name : #BabylonDelaunayTriangulatorVertex,
	#superclass : #Object,
	#instVars : [
		'index',
		'position'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #comparing }
BabylonDelaunayTriangulatorVertex >> < other [
	position x = other position x ifTrue: [ 
		^ position y < other position y
	].

	^ position x < other position x
]

{ #category : #comparing }
BabylonDelaunayTriangulatorVertex >> <= other [
	position x = other position x ifTrue: [ 
		^ position y <= other position y
	].

	^ position x < other position x
]

{ #category : #accessing }
BabylonDelaunayTriangulatorVertex >> index [
	^ index
]

{ #category : #accessing }
BabylonDelaunayTriangulatorVertex >> index: anObject [
	index := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorVertex >> position [
	^ position
]

{ #category : #accessing }
BabylonDelaunayTriangulatorVertex >> position: anObject [
	position := anObject
]
