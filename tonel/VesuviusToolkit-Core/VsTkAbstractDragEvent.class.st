Class {
	#name : #VsTkAbstractDragEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'initialButton',
		'buttonState',
		'modifiers',
		'position'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkAbstractDragEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
VsTkAbstractDragEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
VsTkAbstractDragEvent >> initialButton [
	^ initialButton
]

{ #category : #accessing }
VsTkAbstractDragEvent >> initialButton: anObject [
	initialButton := anObject
]

{ #category : #testing }
VsTkAbstractDragEvent >> isMiddleButtonDrag [
	^ initialButton = 2
]

{ #category : #testing }
VsTkAbstractDragEvent >> isPrimaryButtonDrag [
	^ initialButton = 1
]

{ #category : #testing }
VsTkAbstractDragEvent >> isSecondaryButtonDrag [
	^ initialButton = 3
]

{ #category : #accessing }
VsTkAbstractDragEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkAbstractDragEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkAbstractDragEvent >> position [
	^ position
]

{ #category : #accessing }
VsTkAbstractDragEvent >> position: anObject [
	position := anObject
]
