Class {
	#name : #PompeiiTextureArrayElementMaterial,
	#superclass : #PompeiiMaterial,
	#instVars : [
		'textureArray',
		'elementIndex'
	],
	#category : #'PompeiiGraphics-Core-Material'
}

{ #category : #initialization }
PompeiiTextureArrayElementMaterial >> activateMaterialIn: aSurface [
	^ aSurface activateTextureArrayElementMaterial: self
]

{ #category : #accessing }
PompeiiTextureArrayElementMaterial >> elementIndex [
	^ elementIndex
]

{ #category : #accessing }
PompeiiTextureArrayElementMaterial >> elementIndex: anObject [
	elementIndex := anObject
]

{ #category : #accessing }
PompeiiTextureArrayElementMaterial >> textureArray [
	^ textureArray
]

{ #category : #accessing }
PompeiiTextureArrayElementMaterial >> textureArray: anObject [
	textureArray := anObject
]
