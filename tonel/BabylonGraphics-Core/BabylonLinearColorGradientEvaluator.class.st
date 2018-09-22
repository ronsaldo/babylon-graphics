"
I am evaluator that computes a linear color gradient, with only two stops.
"
Class {
	#name : #BabylonLinearColorGradientEvaluator,
	#superclass : #BabylonColorEvaluator,
	#instVars : [
		'startColor',
		'endColor',
		'startPoint',
		'direction',
		'inverseLength'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #computing }
BabylonLinearColorGradientEvaluator >> computeColor: aPosition [
	| alpha delta |
	delta := aPosition - startPoint.
	alpha := ((delta x * direction x) + (delta y * direction y)) * inverseLength min: 1.0 max: 0.0.
	^ self interpolateColorStart: startColor end: endColor alpha: alpha
]

{ #category : #accessing }
BabylonLinearColorGradientEvaluator >> endColor [
	^ endColor
]

{ #category : #accessing }
BabylonLinearColorGradientEvaluator >> endColor: anObject [
	endColor := anObject
]

{ #category : #accessing }
BabylonLinearColorGradientEvaluator >> startColor [
	^ startColor
]

{ #category : #accessing }
BabylonLinearColorGradientEvaluator >> startColor: anObject [
	startColor := anObject
]

{ #category : #accessing }
BabylonLinearColorGradientEvaluator >> startPosition: startPosition endPosition: endPosition [
	| length |
	startPoint := startPosition.
	direction := endPosition - startPosition.
	length := ((direction x * direction x) + (direction y * direction y)) sqrt.
	inverseLength := (length closeTo: 0) ifTrue: [0] ifFalse: [ length reciprocal ].
	direction := direction * inverseLength.
]
