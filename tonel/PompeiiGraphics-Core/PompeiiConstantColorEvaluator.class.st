"
I am evaluator that only computes constant color information.
"
Class {
	#name : #PompeiiConstantColorEvaluator,
	#superclass : #PompeiiColorEvaluator,
	#instVars : [
		'color'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #accessing }
PompeiiConstantColorEvaluator class >> builder: builder color: aColor [
	^ self new builder: builder; color: aColor
]

{ #category : #accessing }
PompeiiConstantColorEvaluator >> color [
	^ color
]

{ #category : #accessing }
PompeiiConstantColorEvaluator >> color: anObject [
	color := anObject
]

{ #category : #computing }
PompeiiConstantColorEvaluator >> computeColor: aPosition [
	^ color
]
