"
I am a texture that can be used for rendering.
"
Class {
	#name : #PompeiiSurface,
	#superclass : #PompeiiTexture,
	#category : #'PompeiiGraphics-Core'
}

{ #category : #converting }
PompeiiSurface >> asForm [
	self subclassResponsibility
]

{ #category : #drawing }
PompeiiSurface >> drawDuring: aBlock [
	self subclassResponsibility
]

{ #category : #drawing }
PompeiiSurface >> drawToOSWindow: anOSWindow during: aBlock [
	self subclassResponsibility
]
