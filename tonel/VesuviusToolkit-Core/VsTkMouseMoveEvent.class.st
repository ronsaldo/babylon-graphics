Class {
	#name : #VsTkMouseMoveEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'buttonState',
		'modifiers',
		'position',
		'delta'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkMouseMoveEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
VsTkMouseMoveEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
VsTkMouseMoveEvent >> delta [
	^ delta
]

{ #category : #accessing }
VsTkMouseMoveEvent >> delta: anObject [
	delta := anObject
]

{ #category : #'initialize-release' }
VsTkMouseMoveEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseMove: self
]

{ #category : #accessing }
VsTkMouseMoveEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkMouseMoveEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkMouseMoveEvent >> position [
	^ position
]

{ #category : #accessing }
VsTkMouseMoveEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
VsTkMouseMoveEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
