"
I represent an event in the Vesubius toolkit.
"
Class {
	#name : #VsTkEvent,
	#superclass : #Object,
	#instVars : [
		'wasHandled',
		'skipPropagation'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkEvent >> handleWith: anEventHandler [
	self subclassResponsibility
]

{ #category : #initialization }
VsTkEvent >> initialize [
	super initialize.
	wasHandled := false.
	skipPropagation := false.
	
]

{ #category : #accessing }
VsTkEvent >> skipPropagation [
	^ skipPropagation
]

{ #category : #accessing }
VsTkEvent >> skipPropagation: anObject [
	skipPropagation := anObject
]

{ #category : #accessing }
VsTkEvent >> wasHandled [
	^ wasHandled
]

{ #category : #accessing }
VsTkEvent >> wasHandled: anObject [
	wasHandled := anObject
]
