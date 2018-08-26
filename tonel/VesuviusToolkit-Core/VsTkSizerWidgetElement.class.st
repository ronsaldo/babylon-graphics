"
I represent a widget that is shaped by a sizer.
"
Class {
	#name : #VsTkSizerWidgetElement,
	#superclass : #VsTkSizerElement,
	#instVars : [
		'widget'
	],
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #applying }
VsTkSizerWidgetElement >> applyIntoExtent: newExtent position: position [
	| adjustedBounds |
	adjustedBounds := self adjustExtent: newExtent position: position.
	widget position: adjustedBounds origin extent: adjustedBounds extent
]

{ #category : #accessing }
VsTkSizerWidgetElement >> extent [
	^ widget extentForLayoutComputation
]

{ #category : #accessing }
VsTkSizerWidgetElement >> minimalExtent [
	^ widget minimalExtent + self borderExtent
]

{ #category : #accessing }
VsTkSizerWidgetElement >> widget [
	^ widget
]

{ #category : #accessing }
VsTkSizerWidgetElement >> widget: anObject [
	widget := anObject
]
