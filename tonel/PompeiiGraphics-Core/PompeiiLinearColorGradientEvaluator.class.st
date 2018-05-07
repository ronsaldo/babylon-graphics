"
I am evaluator that computes a linear color gradient, with only two stops.
"
Class {
	#name : #PompeiiLinearColorGradientEvaluator,
	#superclass : #PompeiiColorEvaluator,
	#instVars : [
		'startColor',
		'endColor',
		'startPoint',
		'direction',
		'inverseLength'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #computing }
PompeiiLinearColorGradientEvaluator >> computeColor: aPosition [
	| alpha delta |
	delta := aPosition - startPoint.
	alpha := ((delta x * direction x) + (delta y * direction y)) * inverseLength min: 1.0 max: 0.0.
	^ self interpolateColorStart: startColor end: endColor alpha: alpha
]

{ #category : #accessing }
PompeiiLinearColorGradientEvaluator >> endColor [
	^ endColor
]

{ #category : #accessing }
PompeiiLinearColorGradientEvaluator >> endColor: anObject [
	endColor := anObject
]

{ #category : #accessing }
PompeiiLinearColorGradientEvaluator >> startColor [
	^ startColor
]

{ #category : #accessing }
PompeiiLinearColorGradientEvaluator >> startColor: anObject [
	startColor := anObject
]

{ #category : #accessing }
PompeiiLinearColorGradientEvaluator >> startPosition: startPosition endPosition: endPosition [
	| length |
	startPoint := startPosition.
	direction := endPosition - startPosition.
	length := ((direction x * direction x) + (direction y * direction y)) sqrt.
	inverseLength := (length closeTo: 0) ifTrue: [0] ifFalse: [ length reciprocal ].
	direction := direction * inverseLength.
]
