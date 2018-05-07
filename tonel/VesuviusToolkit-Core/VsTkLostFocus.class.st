Class {
	#name : #VsTkLostFocus,
	#superclass : #VsTkFocusEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkLostFocus >> handleWith: anEventHandler [
	^ anEventHandler handleLostFocus: anEventHandler
]
