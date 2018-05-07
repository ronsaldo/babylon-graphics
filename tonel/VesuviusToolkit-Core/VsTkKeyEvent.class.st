Class {
	#name : #VsTkKeyEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'key',
		'modifiers'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkKeyEvent >> key [
	^ key
]

{ #category : #accessing }
VsTkKeyEvent >> key: anObject [
	key := anObject
]

{ #category : #accessing }
VsTkKeyEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkKeyEvent >> modifiers: anObject [
	modifiers := anObject
]
