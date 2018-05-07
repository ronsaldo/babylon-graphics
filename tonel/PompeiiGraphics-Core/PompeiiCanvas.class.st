"
I provide a canvas rendering API.
"
Class {
	#name : #PompeiiCanvas,
	#superclass : #Object,
	#category : #'PompeiiGraphics-Core'
}

{ #category : #'drawing commands' }
PompeiiCanvas >> clear [
	self clear: Color transparent
]

{ #category : #'drawing commands' }
PompeiiCanvas >> clear: clearColor [
	self subclassResponsibility
]

{ #category : #'drawing commands' }
PompeiiCanvas >> draw: aShape [
	^ self drawConvertedShape: (aShape asPompeiiShapeFor: self driver)
]

{ #category : #'drawing commands' }
PompeiiCanvas >> drawConvertedShapeWith: aConvertedShape [
	self subclassResponsibility
]

{ #category : #'drawing commands' }
PompeiiCanvas >> driver [
	self subclassResponsibility
]
