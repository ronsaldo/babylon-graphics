Class {
	#name : #BabylonBlendingMode,
	#superclass : #Object,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'BabylonGraphics-Core-Blending'
}

{ #category : #accessing }
BabylonBlendingMode class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #rendering }
BabylonBlendingMode >> blendSourceColor: sourceColor withDestColor: destColor [
	self subclassResponsibility
]

{ #category : #rendering }
BabylonBlendingMode >> renderBuffer: renderBuffer at: pixelIndex blendWithLinearColor: linearColor [
	| destColor blendedColor |
	destColor := BabylonLinearColor decodeBGRA: (renderBuffer at: pixelIndex).
	blendedColor := self blendSourceColor: linearColor withDestColor: destColor.
	renderBuffer at: pixelIndex put: blendedColor asBGRA32
]
