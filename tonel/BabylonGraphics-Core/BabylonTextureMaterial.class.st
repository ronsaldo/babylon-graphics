Class {
	#name : #BabylonTextureMaterial,
	#superclass : #BabylonMaterial,
	#instVars : [
		'grayscaleTexture',
		'texture'
	],
	#category : #'BabylonGraphics-Core-Material'
}

{ #category : #initialization }
BabylonTextureMaterial >> activateMaterialIn: aSurface [
	^ aSurface activateTextureMaterial: self
]

{ #category : #accessing }
BabylonTextureMaterial >> grayscaleTexture [
	^ grayscaleTexture
]

{ #category : #accessing }
BabylonTextureMaterial >> grayscaleTexture: anObject [
	grayscaleTexture := anObject
]

{ #category : #initialization }
BabylonTextureMaterial >> initialize [
	super initialize.
	grayscaleTexture := false.
]

{ #category : #accessing }
BabylonTextureMaterial >> texture [
	^ texture
]

{ #category : #accessing }
BabylonTextureMaterial >> texture: anObject [
	texture := anObject
]
