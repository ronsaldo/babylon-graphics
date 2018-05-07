Class {
	#name : #VsTkMouseButtonEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'button',
		'buttonState',
		'modifiers',
		'position'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkMouseButtonEvent >> button [
	^ button
]

{ #category : #accessing }
VsTkMouseButtonEvent >> button: anObject [
	button := anObject
]

{ #category : #accessing }
VsTkMouseButtonEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
VsTkMouseButtonEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
VsTkMouseButtonEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkMouseButtonEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkMouseButtonEvent >> position [
	^ position
]

{ #category : #accessing }
VsTkMouseButtonEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
VsTkMouseButtonEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
