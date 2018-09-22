Class {
	#name : #CyTkMouseWheelEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'buttonState',
		'modifiers',
		'position',
		'scrollHorizontal',
		'scrollVertical'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkMouseWheelEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
CyTkMouseWheelEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #'initialize-release' }
CyTkMouseWheelEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseWheel: self
]

{ #category : #accessing }
CyTkMouseWheelEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkMouseWheelEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkMouseWheelEvent >> position [
	^ position
]

{ #category : #accessing }
CyTkMouseWheelEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
CyTkMouseWheelEvent >> scrollHorizontal [
	^ scrollHorizontal
]

{ #category : #accessing }
CyTkMouseWheelEvent >> scrollHorizontal: anObject [
	scrollHorizontal := anObject
]

{ #category : #accessing }
CyTkMouseWheelEvent >> scrollVertical [
	^ scrollVertical
]

{ #category : #accessing }
CyTkMouseWheelEvent >> scrollVertical: anObject [
	scrollVertical := anObject
]

{ #category : #'as yet unclassified' }
CyTkMouseWheelEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
