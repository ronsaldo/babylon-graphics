Class {
	#name : #CyTkMouseMoveEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'buttonState',
		'modifiers',
		'position',
		'delta'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkMouseMoveEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
CyTkMouseMoveEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #accessing }
CyTkMouseMoveEvent >> delta [
	^ delta
]

{ #category : #accessing }
CyTkMouseMoveEvent >> delta: anObject [
	delta := anObject
]

{ #category : #'initialize-release' }
CyTkMouseMoveEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseMove: self
]

{ #category : #accessing }
CyTkMouseMoveEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkMouseMoveEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkMouseMoveEvent >> position [
	^ position
]

{ #category : #accessing }
CyTkMouseMoveEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
CyTkMouseMoveEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
