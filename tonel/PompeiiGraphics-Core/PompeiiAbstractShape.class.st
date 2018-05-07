"
I represent an abstract shape that can be renderer in a Pompeii canvas.
"
Class {
	#name : #PompeiiAbstractShape,
	#superclass : #Object,
	#category : #'PompeiiGraphics-Core'
}

{ #category : #converting }
PompeiiAbstractShape >> asPompeiiGenericShape [
	^ self
]

{ #category : #converting }
PompeiiAbstractShape >> asPompeiiShapeFor: aPompeiiDriver [
	"Note: The answered object of this message should conform with PompeiiShape protocol."
	self subclassResponsibility
]
