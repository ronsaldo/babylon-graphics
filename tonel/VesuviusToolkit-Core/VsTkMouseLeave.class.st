Class {
	#name : #VsTkMouseLeave,
	#superclass : #VsTkFocusEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkMouseLeave >> handleWith: anEventHandler [
	^ anEventHandler handleMouseLeave: anEventHandler
]
