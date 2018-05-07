Extension { #name : #Color }

{ #category : #'*PompeiiGraphics-Core' }
Color >> pompeiiLinearToSRGB [
	^ Color r: self red pompeiiLinearToSRGB g: self green pompeiiLinearToSRGB b: self blue pompeiiLinearToSRGB alpha: self alpha
]

{ #category : #'*PompeiiGraphics-Core' }
Color >> pompeiiSRGBToLinear [
	^ Color r: self red pompeiiLinearToSRGB g: self green pompeiiLinearToSRGB b: self blue pompeiiLinearToSRGB alpha: self alpha
]
