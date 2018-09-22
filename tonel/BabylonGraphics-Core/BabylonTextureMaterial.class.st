Class {
	#name : #BabylonTextureMaterial,
	#superclass : #BabylonMaterial,
	#instVars : [
		'texture'
	],
	#category : #'BabylonGraphics-Core-Material'
}

{ #category : #initialization }
BabylonTextureMaterial >> activateMaterialIn: aSurface [
	^ aSurface activateTextureMaterial: self
]

{ #category : #accessing }
BabylonTextureMaterial >> texture [
	^ texture
]

{ #category : #accessing }
BabylonTextureMaterial >> texture: anObject [
	texture := anObject
]
