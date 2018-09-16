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
Color >> asPompeiiLinearColor [
	^ PompeiiLinearColor r: self red pompeiiSRGBToLinear g: self green pompeiiSRGBToLinear b: self blue pompeiiSRGBToLinear a: self alpha
]

{ #category : #'*PompeiiGraphics-Core' }
Color >> pompeiiLinearToSRGB [
	^ Color r: self red pompeiiSRGBToLinear g: self green pompeiiSRGBToLinear b: self blue pompeiiSRGBToLinear alpha: self alpha
]
