Class {
	#name : #VsTkMouseButtonUpEvent,
	#superclass : #VsTkMouseButtonEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkMouseButtonUpEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseButtonUp: self
]
