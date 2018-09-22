Class {
	#name : #CyTkClickEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'modifiers',
		'position'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkClickEvent >> handleWith: anEventHandler [
	^ anEventHandler handleClick: self
]

{ #category : #accessing }
CyTkClickEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkClickEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkClickEvent >> position [
	^ position
]

{ #category : #accessing }
CyTkClickEvent >> position: anObject [
	position := anObject
]

{ #category : #'as yet unclassified' }
CyTkClickEvent >> toLocalOrigin: localOrigin [
	^ self copy position: position - localOrigin
]
