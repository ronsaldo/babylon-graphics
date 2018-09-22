Extension { #name : #Color }

{ #category : #'*BabylonGraphics-Core' }
Color >> applyPaintInBabylonBuilder: builder [
	builder color: self
]

{ #category : #'*BabylonGraphics-Core' }
Color >> applyPaintInBabylonBuilder: builder tileRectangle: aRectangle [
	builder color: self
]

{ #category : #'*BabylonGraphics-Core' }
Color >> asBabylonLinearColor [
	^ BabylonLinearColor r: self red babylonSRGBToLinear g: self green babylonSRGBToLinear b: self blue babylonSRGBToLinear a: self alpha
]

{ #category : #'*BabylonGraphics-Core' }
Color >> babylonLinearToSRGB [
	^ Color r: self red babylonSRGBToLinear g: self green babylonSRGBToLinear b: self blue babylonSRGBToLinear alpha: self alpha
]
