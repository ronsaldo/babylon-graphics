"
I represent an abstract shape that can be renderer in a Pompeii canvas.
"
Class {
	#name : #BabylonAbstractShape,
	#superclass : #Object,
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #converting }
BabylonAbstractShape >> asBabylonGenericShape [
	^ self
]

{ #category : #converting }
BabylonAbstractShape >> asBabylonShapeFor: aPompeiiDriver [
	"Note: The answered object of this message should conform with PompeiiShape protocol."
	self subclassResponsibility
]
