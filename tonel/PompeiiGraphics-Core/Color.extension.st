Extension { #name : #Color }

{ #category : #'*PompeiiGraphics-Core' }
Color >> applyPaintInPompeiiBuilder: builder [
	builder color: self
]

{ #category : #'*PompeiiGraphics-Core' }
Color >> applyPaintInPompeiiBuilder: builder tileRectangle: aRectangle [
	builder color: self
]

{ #category : #'*PompeiiGraphics-Core' }
Color >> pompeiiLinearToSRGB [
	^ Color r: self red pompeiiLinearToSRGB g: self green pompeiiLinearToSRGB b: self blue pompeiiLinearToSRGB alpha: self alpha
]

{ #category : #'*PompeiiGraphics-Core' }
Color >> pompeiiSRGBToLinear [
	^ Color r: self red pompeiiLinearToSRGB g: self green pompeiiLinearToSRGB b: self blue pompeiiLinearToSRGB alpha: self alpha
]
