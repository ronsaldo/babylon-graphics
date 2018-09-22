Class {
	#name : #CyTkEventDispatcher,
	#superclass : #Object,
	#instVars : [
		'handlers'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #initialization }
CyTkEventDispatcher >> initialize [
	super initialize.
	handlers := IdentityDictionary new.
]

{ #category : #initialization }
CyTkEventDispatcher >> on: anEventClass do: anAction [
	handlers at: anEventClass put: anAction
]

{ #category : #'events-processing' }
CyTkEventDispatcher >> processEvent: anEvent [
	handlers at: anEvent class ifPresent: [ :handler |
		handler ifNotNil: [ 
			handler value: anEvent
		]
	]
]
