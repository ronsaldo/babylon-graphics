"
A sizer is an object for building layouts. We are taking inspiration on WxWidgets for this.
"
Class {
	#name : #CyTkSizer,
	#superclass : #Object,
	#instVars : [
		'elements'
	],
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #applying }
CyTkSizer >> applyIntoExtent: newExtent position: position [
	self subclassResponsibility
]

{ #category : #converting }
CyTkSizer >> asSizerElement [
	^ CyTkSizerSubSizerElement new sizer: self
]

{ #category : #building }
CyTkSizer >> element: aWidgetOrASizer do: aBlock [
	| element |
	element := aWidgetOrASizer asSizerElement.
	aBlock value: element.
	elements add: element.
]

{ #category : #initialization }
CyTkSizer >> initialize [
	super initialize.
	elements := OrderedCollection new.
	
]

{ #category : #applying }
CyTkSizer >> minimalExtent [
	self subclassResponsibility
]
