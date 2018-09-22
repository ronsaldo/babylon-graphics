"
I am abstract host window, with an actual surface and probably and actual operating system window.
"
Class {
	#name : #CyTkAbstractHostWindow,
	#superclass : #CyTkVirtualHostWindow,
	#instVars : [
		'session',
		'surface'
	],
	#category : #'CyrusToolkit-Core-Host'
}

{ #category : #'session management' }
CyTkAbstractHostWindow >> checkSession [
	session ~~ Smalltalk session ifTrue: [
		self initializeForNewSession
	].
	
]

{ #category : #'session management' }
CyTkAbstractHostWindow >> checkSurface [
	(surface isNotNil and: [ surface extent = self surfaceExtent ]) ifTrue: [ ^ self ].
	surface ifNil: [ 
		graphicsDriver := BabylonDriver current.
		surface := graphicsDriver surfaceWithExtent: self surfaceExtent asIntegerPoint.
	].

	surface extent: self surfaceExtent.
]

{ #category : #focus }
CyTkAbstractHostWindow >> close [
	surface ifNotNil: #destroy.
]

{ #category : #initialization }
CyTkAbstractHostWindow >> initialize [
	super initialize.
	session := Smalltalk session.
	
]

{ #category : #'session management' }
CyTkAbstractHostWindow >> initializeForNewSession [
	surface := nil.	
]
