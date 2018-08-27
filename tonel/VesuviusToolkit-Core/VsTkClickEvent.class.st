Class {
	#name : #VsTkClickEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'modifiers',
		'position'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkClickEvent >> handleWith: anEventHandler [
	^ anEventHandler handleClick: self
]

{ #category : #accessing }
VsTkClickEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkClickEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkClickEvent >> position [
	^ position
]

{ #category : #accessing }
VsTkClickEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
VsTkClickEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
