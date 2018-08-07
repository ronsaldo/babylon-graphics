"
I am a texture that can be used for rendering.
"
Class {
	#name : #PompeiiSurface,
	#superclass : #PompeiiTexture,
	#category : #'PompeiiGraphics-Core'
}

{ #category : #'material activation' }
PompeiiSurface >> activateFontMaterial: aFontMaterial [
	self subclassResponsibility
]

{ #category : #'material activation' }
PompeiiSurface >> activateTextureArrayElementMaterial: aFontMaterial [
	self subclassResponsibility
]

{ #category : #'material activation' }
PompeiiSurface >> activateTextureMaterial: aFontMaterial [
	self subclassResponsibility
]

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
