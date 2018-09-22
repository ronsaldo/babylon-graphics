Class {
	#name : #CyTkGotFocus,
	#superclass : #CyTkFocusEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkGotFocus >> handleWith: anEventHandler [
	^ anEventHandler handleGotFocus: anEventHandler
]
