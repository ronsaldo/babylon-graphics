"
I am used to evaluate the position of a vertex and computing some of its attributes such as its color and texture coordinate.
"
Class {
	#name : #PompeiiMeshPartEvaluator,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #accessing }
PompeiiMeshPartEvaluator >> builder [
	^ builder
]

{ #category : #accessing }
PompeiiMeshPartEvaluator >> builder: anObject [
	builder := anObject
]

{ #category : #computing }
PompeiiMeshPartEvaluator >> computeColor: aPosition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PompeiiMeshPartEvaluator >> computePosition: aPosition [
	^ builder transform transform: aPosition
]

{ #category : #computing }
PompeiiMeshPartEvaluator >> computeTexcoord: aPosition [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PompeiiMeshPartEvaluator >> computeVertex: aPosition [
	^ PompeiiMesh2DVertex new
			position: (self computePosition: aPosition);
			color: (self computeColor: aPosition);
			texcoord: (self computeTexcoord: aPosition);
			yourself
]

{ #category : #'as yet unclassified' }
PompeiiMeshPartEvaluator >> computeVertex: aPosition texcoord: aTexcoord [
	^ PompeiiMesh2DVertex new
			position: (self computePosition: aPosition);
			color: (self computeColor: aPosition);
			texcoord: aTexcoord;
			yourself
]

{ #category : #'as yet unclassified' }
PompeiiMeshPartEvaluator >> interpolateColorStart: startColor end: endColor alpha: alpha [
	^ ((startColor pompeiiSRGBToLinear * (1.0 - alpha)) + (endColor pompeiiSRGBToLinear * alpha)) pompeiiLinearToSRGB
]
