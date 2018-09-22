Extension { #name : #Rectangle }

{ #category : #'*BabylonGraphics-Core' }
Rectangle >> asBabylonGenericShape [
	^ BabylonConvexPolygon rectangle: self
]

{ #category : #'*BabylonGraphics-Core' }
Rectangle >> asBabylonShapeFor: aPompeiiDriver [
	^ self asBabylonGenericShape asBabylonShapeFor: aPompeiiDriver
]
