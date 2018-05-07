Class {
	#name : #VsTkGotFocus,
	#superclass : #VsTkFocusEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkGotFocus >> handleWith: anEventHandler [
	^ anEventHandler handleGotFocus: anEventHandler
]
