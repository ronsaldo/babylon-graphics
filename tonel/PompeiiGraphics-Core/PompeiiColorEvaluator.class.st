"
I am evaluator that only computes color information.
"
Class {
	#name : #PompeiiColorEvaluator,
	#superclass : #PompeiiMeshPartEvaluator,
	#classVars : [
		'ZeroTexcoord'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #initialization }
PompeiiColorEvaluator class >> initialize [
	ZeroTexcoord := 0@0
]

{ #category : #computing }
PompeiiColorEvaluator >> computeTexcoord: aPosition [
	^ ZeroTexcoord
]
