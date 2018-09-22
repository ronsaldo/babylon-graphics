Class {
	#name : #CyTkTextInputEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'text'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkTextInputEvent >> handleWith: anEventHandler [
	^ anEventHandler handleTextInput: self
]

{ #category : #accessing }
CyTkTextInputEvent >> text [
	^ text
]

{ #category : #accessing }
CyTkTextInputEvent >> text: anObject [
	text := anObject
]
