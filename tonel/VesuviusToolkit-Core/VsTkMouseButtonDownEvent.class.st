Class {
	#name : #VsTkMouseButtonDownEvent,
	#superclass : #VsTkMouseButtonEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkMouseButtonDownEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseButtonDown: self
]
