"
I am a texture that can be used for rendering.
"
Class {
	#name : #BabylonSurface,
	#superclass : #BabylonTexture,
	#category : #'BabylonGraphics-Core'
}

{ #category : #'material activation' }
BabylonSurface >> activateFontMaterial: aFontMaterial [
	self subclassResponsibility
]

{ #category : #'material activation' }
BabylonSurface >> activateTextureArrayElementMaterial: aFontMaterial [
	self subclassResponsibility
]

{ #category : #'material activation' }
BabylonSurface >> activateTextureMaterial: aFontMaterial [
	self subclassResponsibility
]

{ #category : #converting }
BabylonSurface >> asForm [
	self subclassResponsibility
]

{ #category : #initialize }
BabylonSurface >> destroy [
]

{ #category : #drawing }
BabylonSurface >> drawDuring: aBlock [
	self subclassResponsibility
]

{ #category : #drawing }
BabylonSurface >> drawToOSWindow: anOSWindow during: aBlock [
	self subclassResponsibility
]
