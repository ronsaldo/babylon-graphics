Class {
	#name : #BabylonTextureArrayElementMaterial,
	#superclass : #BabylonMaterial,
	#instVars : [
		'textureArray',
		'elementIndex'
	],
	#category : #'BabylonGraphics-Core-Material'
}

{ #category : #initialization }
BabylonTextureArrayElementMaterial >> activateMaterialIn: aSurface [
	^ aSurface activateTextureArrayElementMaterial: self
]

{ #category : #accessing }
BabylonTextureArrayElementMaterial >> elementIndex [
	^ elementIndex
]

{ #category : #accessing }
BabylonTextureArrayElementMaterial >> elementIndex: anObject [
	elementIndex := anObject
]

{ #category : #accessing }
BabylonTextureArrayElementMaterial >> textureArray [
	^ textureArray
]

{ #category : #accessing }
BabylonTextureArrayElementMaterial >> textureArray: anObject [
	textureArray := anObject
]
