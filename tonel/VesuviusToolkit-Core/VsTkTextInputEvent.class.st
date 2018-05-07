Class {
	#name : #VsTkTextInputEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'text'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkTextInputEvent >> handleWith: anEventHandler [
	^ anEventHandler handleTextInput: self
]

{ #category : #accessing }
VsTkTextInputEvent >> text [
	^ text
]

{ #category : #accessing }
VsTkTextInputEvent >> text: anObject [
	text := anObject
]
