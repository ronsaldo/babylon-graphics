Class {
	#name : #CyTkLostFocus,
	#superclass : #CyTkFocusEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkLostFocus >> handleWith: anEventHandler [
	^ anEventHandler handleLostFocus: anEventHandler
]
