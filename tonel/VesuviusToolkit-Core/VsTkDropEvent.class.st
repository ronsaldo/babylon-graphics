Class {
	#name : #VsTkDropEvent,
	#superclass : #VsTkAbstractDragEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkDropEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDropEvent: self
]
