Extension { #name : #Rectangle }

{ #category : #'*PompeiiGraphics-Core' }
Rectangle >> asPompeiiGenericShape [
	^ PompeiiConvexPolygon rectangle: self
]

{ #category : #'*PompeiiGraphics-Core' }
Rectangle >> asPompeiiShapeFor: aPompeiiDriver [
	^ self asPompeiiGenericShape asPompeiiShapeFor: aPompeiiDriver
]
