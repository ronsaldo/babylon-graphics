"
I represent a sizer inside of another sizer.
"
Class {
	#name : #VsTkSizerSubSizerElement,
	#superclass : #VsTkSizerElement,
	#instVars : [
		'sizer'
	],
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #applying }
VsTkSizerSubSizerElement >> applyIntoExtent: newExtent position: position [
	| adjustedBounds |
	adjustedBounds := self adjustExtent: newExtent position: position.
	sizer applyIntoExtent: adjustedBounds extent position: adjustedBounds origin
]

{ #category : #accessing }
VsTkSizerSubSizerElement >> extent [
	^ sizer extent + self borderExtent
]

{ #category : #applying }
VsTkSizerSubSizerElement >> minimalExtent [
	^ sizer minimalExtent + self borderExtent
]

{ #category : #accessing }
VsTkSizerSubSizerElement >> sizer [
	^ sizer
]

{ #category : #accessing }
VsTkSizerSubSizerElement >> sizer: anObject [
	sizer := anObject
]
