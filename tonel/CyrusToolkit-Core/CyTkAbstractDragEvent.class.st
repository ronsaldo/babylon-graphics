Class {
	#name : #CyTkAbstractDragEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'initialButton',
		'buttonState',
		'modifiers',
		'position'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkAbstractDragEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
CyTkAbstractDragEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
CyTkAbstractDragEvent >> initialButton [
	^ initialButton
]

{ #category : #accessing }
CyTkAbstractDragEvent >> initialButton: anObject [
	initialButton := anObject
]

{ #category : #testing }
CyTkAbstractDragEvent >> isMiddleButtonDrag [
	^ initialButton = 2
]

{ #category : #testing }
CyTkAbstractDragEvent >> isPrimaryButtonDrag [
	^ initialButton = 1
]

{ #category : #testing }
CyTkAbstractDragEvent >> isSecondaryButtonDrag [
	^ initialButton = 3
]

{ #category : #accessing }
CyTkAbstractDragEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkAbstractDragEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkAbstractDragEvent >> position [
	^ position
]

{ #category : #accessing }
CyTkAbstractDragEvent >> position: anObject [
	position := anObject
]
