Class {
	#name : #VsTkMouseWheelEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'buttonState',
		'modifiers',
		'position',
		'scrollHorizontal',
		'scrollVertical'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkMouseWheelEvent >> buttonState [
	^ buttonState
]

{ #category : #accessing }
VsTkMouseWheelEvent >> buttonState: anObject [
	buttonState := anObject
]

{ #category : #'initialize-release' }
VsTkMouseWheelEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseWheel: self
]

{ #category : #accessing }
VsTkMouseWheelEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkMouseWheelEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkMouseWheelEvent >> position [
	^ position
]

{ #category : #accessing }
VsTkMouseWheelEvent >> position: anObject [
	position := anObject
]

{ #category : #accessing }
VsTkMouseWheelEvent >> scrollHorizontal [
	^ scrollHorizontal
]

{ #category : #accessing }
VsTkMouseWheelEvent >> scrollHorizontal: anObject [
	scrollHorizontal := anObject
]

{ #category : #accessing }
VsTkMouseWheelEvent >> scrollVertical [
	^ scrollVertical
]

{ #category : #accessing }
VsTkMouseWheelEvent >> scrollVertical: anObject [
	scrollVertical := anObject
]

{ #category : #'as yet unclassified' }
VsTkMouseWheelEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
