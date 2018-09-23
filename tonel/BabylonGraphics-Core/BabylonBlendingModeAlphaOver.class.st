Class {
	#name : #BabylonBlendingModeAlphaOver,
	#superclass : #BabylonBlendingMode,
	#category : #'BabylonGraphics-Core-Blending'
}

{ #category : #rendering }
BabylonBlendingModeAlphaOver >> blendSourceColor: sourceColor withDestColor: destColor [
	| alpha oneMinusAlpha |
	alpha := sourceColor a.
	oneMinusAlpha := 1.0 - alpha.
	^ BabylonLinearColor
		r: (sourceColor r * alpha) + (destColor r * oneMinusAlpha)
		g: (sourceColor g * alpha) + (destColor g * oneMinusAlpha)
		b: (sourceColor b * alpha) + (destColor b * oneMinusAlpha)
		a: ((alpha + destColor a) min: 1.0)
]
