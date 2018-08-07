Class {
	#name : #PompeiiTextureMaterial,
	#superclass : #PompeiiMaterial,
	#instVars : [
		'texture'
	],
	#category : #'PompeiiGraphics-Core-Material'
}

{ #category : #initialization }
PompeiiTextureMaterial >> activateMaterialIn: aSurface [
	^ aSurface activateTextureMaterial: self
]

{ #category : #accessing }
PompeiiTextureMaterial >> texture [
	^ texture
]

{ #category : #accessing }
PompeiiTextureMaterial >> texture: anObject [
	texture := anObject
]
