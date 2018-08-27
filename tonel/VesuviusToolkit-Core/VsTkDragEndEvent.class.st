Class {
	#name : #VsTkDragEndEvent,
	#superclass : #VsTkAbstractDragEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkDragEndEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragEndEvent: self
]
