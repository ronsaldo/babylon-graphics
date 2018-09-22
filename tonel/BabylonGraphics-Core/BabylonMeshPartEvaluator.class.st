"
I am used to evaluate the position of a vertex and computing some of its attributes such as its color and texture coordinate.
"
Class {
	#name : #BabylonMeshPartEvaluator,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #accessing }
BabylonMeshPartEvaluator >> builder [
	^ builder
]

{ #category : #accessing }
BabylonMeshPartEvaluator >> builder: anObject [
	builder := anObject
]

{ #category : #computing }
BabylonMeshPartEvaluator >> computeColor: aPosition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BabylonMeshPartEvaluator >> computePosition: aPosition [
	^ builder transform transform: aPosition
]

{ #category : #computing }
BabylonMeshPartEvaluator >> computeTexcoord: aPosition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BabylonMeshPartEvaluator >> computeVertex: aPosition [
	^ BabylonMesh2DVertex new
			position: (self computePosition: aPosition);
			color: (self computeColor: aPosition);
			texcoord: (self computeTexcoord: aPosition);
			yourself
]

{ #category : #'as yet unclassified' }
BabylonMeshPartEvaluator >> computeVertex: aPosition texcoord: aTexcoord [
	^ BabylonMesh2DVertex new
			position: (self computePosition: aPosition);
			color: (self computeColor: aPosition);
			texcoord: aTexcoord;
			yourself
]

{ #category : #'as yet unclassified' }
BabylonMeshPartEvaluator >> interpolateColorStart: startColor end: endColor alpha: alpha [
	alpha <= 0.0 ifTrue: [ ^ startColor ].
	alpha >= 1.0 ifTrue: [ ^ endColor ].
	^ ((startColor asBabylonLinearColor * (1.0 - alpha)) + (endColor asBabylonLinearColor * alpha)) asColor
]
