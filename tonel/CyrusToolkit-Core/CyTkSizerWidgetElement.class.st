"
I represent a widget that is shaped by a sizer.
"
Class {
	#name : #CyTkSizerWidgetElement,
	#superclass : #CyTkSizerElement,
	#instVars : [
		'widget'
	],
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #applying }
CyTkSizerWidgetElement >> applyIntoExtent: newExtent position: position [
	| adjustedBounds |
	adjustedBounds := self adjustExtent: newExtent position: position.
	widget position: adjustedBounds origin extent: adjustedBounds extent
]

{ #category : #accessing }
CyTkSizerWidgetElement >> extent [
	^ widget extentForLayoutComputation
]

{ #category : #accessing }
CyTkSizerWidgetElement >> minimalExtent [
	^ widget minimalExtent + self borderExtent
]

{ #category : #accessing }
CyTkSizerWidgetElement >> widget [
	^ widget
]

{ #category : #accessing }
CyTkSizerWidgetElement >> widget: anObject [
	widget := anObject
]
