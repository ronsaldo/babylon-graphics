"
I am evaluator that only computes constant color information.
"
Class {
	#name : #BabylonConstantColorEvaluator,
	#superclass : #BabylonColorEvaluator,
	#instVars : [
		'color'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #accessing }
BabylonConstantColorEvaluator class >> builder: builder color: aColor [
	^ self new builder: builder; color: aColor
]

{ #category : #accessing }
BabylonConstantColorEvaluator >> color [
	^ color
]

{ #category : #accessing }
BabylonConstantColorEvaluator >> color: anObject [
	color := anObject
]

{ #category : #computing }
BabylonConstantColorEvaluator >> computeColor: aPosition [
	^ color
]
