"
I represent a sizer inside of another sizer.
"
Class {
	#name : #CyTkSizerSubSizerElement,
	#superclass : #CyTkSizerElement,
	#instVars : [
		'sizer'
	],
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #applying }
CyTkSizerSubSizerElement >> applyIntoExtent: newExtent position: position [
	| adjustedBounds |
	adjustedBounds := self adjustExtent: newExtent position: position.
	sizer applyIntoExtent: adjustedBounds extent position: adjustedBounds origin
]

{ #category : #accessing }
CyTkSizerSubSizerElement >> extent [
	^ sizer extent + self borderExtent
]

{ #category : #applying }
CyTkSizerSubSizerElement >> minimalExtent [
	^ sizer minimalExtent + self borderExtent
]

{ #category : #accessing }
CyTkSizerSubSizerElement >> sizer [
	^ sizer
]

{ #category : #accessing }
CyTkSizerSubSizerElement >> sizer: anObject [
	sizer := anObject
]
