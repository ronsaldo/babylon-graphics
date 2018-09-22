Extension { #name : #Point }

{ #category : #'*PompeiiGraphics-Core' }
Point >> asFixedPointForPompeiiRendering [
	^ x asFixedPointForPompeiiRendering @ y asFixedPointForPompeiiRendering
]

{ #category : #'*PompeiiGraphics-Core' }
Point >> asPompeiiComplex [
	^ PompeiiComplex x: x y: y
]

{ #category : #'*PompeiiGraphics-Core' }
Point >> fromFixedPointForPompeiiRendering [
	^ x fromFixedPointForPompeiiRendering @ y fromFixedPointForPompeiiRendering
]
