"
A sizer is an object for building layouts. We are taking inspiration on WxWidgets for this.
"
Class {
	#name : #VsTkSizer,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #applying }
VsTkSizer >> applyIntoExtent: newExtent position: position [
	self subclassResponsibility
]

{ #category : #converting }
VsTkSizer >> asSizerElement [
	^ VsTkSizerSubSizerElement new sizer: self
]

{ #category : #building }
VsTkSizer >> element: aWidgetOrASizer do: aBlock [
	| element |
	element := aWidgetOrASizer asSizerElement.
	aBlock value: element.
	elements add: element.
]

{ #category : #initialization }
VsTkSizer >> initialize [
	super initialize.
	elements := OrderedCollection new.
	
]

{ #category : #applying }
VsTkSizer >> minimalExtents [
	self subclassResponsibility
]
