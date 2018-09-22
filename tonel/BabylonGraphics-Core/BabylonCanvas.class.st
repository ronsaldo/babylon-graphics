"
I provide a canvas rendering API.
"
Class {
	#name : #BabylonCanvas,
	#superclass : #Object,
	#category : #'BabylonGraphics-Core'
}

{ #category : #'drawing commands' }
BabylonCanvas >> clear [
	self clear: Color transparent
]

{ #category : #'drawing commands' }
BabylonCanvas >> clear: clearColor [
	self subclassResponsibility
]

{ #category : #'drawing commands' }
BabylonCanvas >> draw: aShape [
	^ self drawConvertedShape: (aShape asBabylonShapeFor: self driver)
]

{ #category : #'drawing commands' }
BabylonCanvas >> drawConvertedShapeWith: aConvertedShape [
	self subclassResponsibility
]

{ #category : #'drawing commands' }
BabylonCanvas >> driver [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
BabylonCanvas >> popClipRectangle [
]

{ #category : #'as yet unclassified' }
BabylonCanvas >> pushClipRectangle: aRectangle [
]
