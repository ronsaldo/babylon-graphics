Extension { #name : #Number }

{ #category : #'*BabylonGraphics-Core' }
Number >> asBabylonComplex [
	^ BabylonComplex r: self
]

{ #category : #'*BabylonGraphics-Core' }
Number >> asBabylonLinearColor [
	^ BabylonLinearColor r: self g: self b: self a: self
]

{ #category : #'*BabylonGraphics-Core' }
Number >> asFixedPointForBabylonRendering [
	^ (self * 4096) floor
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonDecodeLinearChannel [
	^ BabylonLinearColor decodeLinearChannel: self
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonDecodeSRGBColorChannel [
	^ BabylonLinearColor decodeSRGBChannel: self
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonEncodeColorChannel [
	^ (self * 255.0 + 0.5) asInteger min: 255 max: 0
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonEncodeLinearToSRGBColorChannel [
	^ BabylonLinearColor encodeSRGBChannel: self
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonLinearToSRGB [
	^ (self <= 0.0031308 ifTrue: [
		12.92 * self 
	] ifFalse: [
		1.055 * (self raisedTo: 1.0 / 2.4) - 0.055
	])
]

{ #category : #'*BabylonGraphics-Core' }
Number >> babylonSRGBToLinear [
	^	(self <= 0.04045 ifTrue: [
		self / 12.92
	] ifFalse: [
		((self + 0.055) / 1.055) raisedTo: 2.4
	])
]

{ #category : #'*BabylonGraphics-Core' }
Number >> fromFixedPointForBabylonRendering [
	^ self * "1.0 /4096" 0.000244140625
]
