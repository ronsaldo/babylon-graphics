Class {
	#name : #VsTkKeyUpEvent,
	#superclass : #VsTkKeyEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkKeyUpEvent >> handleWith: anEventHandler [
	^ anEventHandler handleKeyUp: self
]
