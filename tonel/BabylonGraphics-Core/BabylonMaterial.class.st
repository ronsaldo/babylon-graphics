"
I represent a generic pompeii material.
"
Class {
	#name : #BabylonMaterial,
	#superclass : #Object,
	#category : #'BabylonGraphics-Core-Material'
}

{ #category : #initialization }
BabylonMaterial >> activateMaterialIn: aSurface [
	self subclassResponsibility
]
