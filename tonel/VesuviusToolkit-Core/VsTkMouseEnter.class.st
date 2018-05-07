Class {
	#name : #VsTkMouseEnter,
	#superclass : #VsTkFocusEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkMouseEnter >> handleWith: anEventHandler [
	^ anEventHandler handleMouseEnter: anEventHandler
]
