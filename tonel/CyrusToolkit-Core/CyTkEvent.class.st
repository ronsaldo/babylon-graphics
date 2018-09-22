"
I represent an event in the Vesubius toolkit.
"
Class {
	#name : #CyTkEvent,
	#superclass : #Object,
	#instVars : [
		'wasHandled',
		'skipPropagation'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkEvent >> handleWith: anEventHandler [
	self subclassResponsibility
]

{ #category : #initialization }
CyTkEvent >> initialize [
	super initialize.
	wasHandled := false.
	skipPropagation := false.
	
]

{ #category : #accessing }
CyTkEvent >> skipPropagation [
	^ skipPropagation
]

{ #category : #accessing }
CyTkEvent >> skipPropagation: anObject [
	skipPropagation := anObject
]

{ #category : #accessing }
CyTkEvent >> wasHandled [
	^ wasHandled
]

{ #category : #accessing }
CyTkEvent >> wasHandled: anObject [
	wasHandled := anObject
]
