Class {
	#name : #BabylonBlendingModeReplace,
	#superclass : #BabylonBlendingMode,
	#category : #'BabylonGraphics-Core-Blending'
}

{ #category : #rendering }
BabylonBlendingModeReplace >> blendSourceColor: sourceColor withDestColor: destColor [
	^ sourceColor
]

{ #category : #rendering }
BabylonBlendingModeReplace >> renderBuffer: renderBuffer at: pixelIndex blendWithLinearColor: linearColor [
	renderBuffer at: pixelIndex put: linearColor asBGRA32
]
