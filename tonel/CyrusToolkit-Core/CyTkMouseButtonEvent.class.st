Class {
	#name : #CyTkMouseButtonEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'button',
		'buttonState',
		'modifiers',
		'position'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkMouseButtonEvent >> button [
	^ button
]

{ #category : #accessing }
CyTkMouseButtonEvent >> button: anObject [
	button := anObject
]

{ #category : #accessing }
CyTkMouseButtonEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
CyTkMouseButtonEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
CyTkMouseButtonEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkMouseButtonEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkMouseButtonEvent >> position [
	^ position
]

{ #category : #accessing }
CyTkMouseButtonEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
CyTkMouseButtonEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
