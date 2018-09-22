Extension { #name : #Point }

{ #category : #'*BabylonGraphics-Core' }
Point >> asBabylonComplex [
	^ BabylonComplex x: x y: y
]

{ #category : #'*BabylonGraphics-Core' }
Point >> asFixedPointForBabylonRendering [
	^ x asFixedPointForBabylonRendering @ y asFixedPointForBabylonRendering
]

{ #category : #'*BabylonGraphics-Core' }
Point >> fromFixedPointForBabylonRendering [
	^ x fromFixedPointForBabylonRendering @ y fromFixedPointForBabylonRendering
]
