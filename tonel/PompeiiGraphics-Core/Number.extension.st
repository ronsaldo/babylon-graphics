Extension { #name : #Number }

{ #category : #'*PompeiiGraphics-Core' }
Number >> asPompeiiComplex [
	^ PompeiiComplex r: self
]

{ #category : #'*PompeiiGraphics-Core' }
Number >> pompeiiLinearToSRGB [
	^ (self <= 0.0031308 ifTrue: [
		12.92 * self 
	] ifFalse: [
		1.055 * (self raisedTo: 1.0 / 2.4) - 0.055
	])
]

{ #category : #'*PompeiiGraphics-Core' }
Number >> pompeiiSRGBToLinear [
	^	(self <= 0.04045 ifTrue: [
		self / 12.92
	] ifFalse: [
		((self + 0.055) / 1.055) raisedTo: 2.4
	])
]
