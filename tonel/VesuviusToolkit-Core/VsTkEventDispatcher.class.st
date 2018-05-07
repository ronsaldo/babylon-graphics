Class {
	#name : #VsTkEventDispatcher,
	#superclass : #Object,
	#instVars : [
		'handlers'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #initialization }
VsTkEventDispatcher >> initialize [
	super initialize.
	handlers := IdentityDictionary new.
]

{ #category : #initialization }
VsTkEventDispatcher >> on: anEventClass do: anAction [
	handlers at: anEventClass put: anAction
]

{ #category : #'events-processing' }
VsTkEventDispatcher >> processEvent: anEvent [
	handlers at: anEvent class ifPresent: [ :handler |
		handler ifNotNil: [ 
			handler value: anEvent
		]
	]
]
