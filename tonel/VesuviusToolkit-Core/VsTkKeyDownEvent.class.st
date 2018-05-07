Class {
	#name : #VsTkKeyDownEvent,
	#superclass : #VsTkKeyEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkKeyDownEvent >> handleWith: anEventHandler [
	^ anEventHandler handleKeyDown: self
]
