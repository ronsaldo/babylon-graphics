"
I am evaluator that only computes color information.
"
Class {
	#name : #BabylonColorEvaluator,
	#superclass : #BabylonMeshPartEvaluator,
	#classVars : [
		'ZeroTexcoord'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #initialization }
BabylonColorEvaluator class >> initialize [
	ZeroTexcoord := 0@0
]

{ #category : #computing }
BabylonColorEvaluator >> computeTexcoord: aPosition [
	^ ZeroTexcoord
]
