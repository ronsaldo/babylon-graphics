"
I am abstract host window, with an actual surface and probably and actual operating system window.
"
Class {
	#name : #VsTkAbstractHostWindow,
	#superclass : #VsTkVirtualHostWindow,
	#instVars : [
		'session',
		'surface'
	],
	#category : #'VesuviusToolkit-Core-Host'
}

{ #category : #'session management' }
VsTkAbstractHostWindow >> checkSession [
	session ~~ Smalltalk session ifTrue: [
		self initializeForNewSession
	].
	
]

{ #category : #'session management' }
VsTkAbstractHostWindow >> checkSurface [
	(surface isNotNil and: [ surface extent = self surfaceExtent ]) ifTrue: [ ^ self ].
	surface ifNil: [ 
		graphicsDriver := PompeiiDriver current.
		surface := graphicsDriver surfaceWithExtent: self surfaceExtent asIntegerPoint.
	].

	surface extent: self surfaceExtent.
]

{ #category : #focus }
VsTkAbstractHostWindow >> close [
	surface ifNotNil: #destroy.
]

{ #category : #initialization }
VsTkAbstractHostWindow >> initialize [
	super initialize.
	session := Smalltalk session.
	
]

{ #category : #'session management' }
VsTkAbstractHostWindow >> initializeForNewSession [
	surface := nil.	
]
