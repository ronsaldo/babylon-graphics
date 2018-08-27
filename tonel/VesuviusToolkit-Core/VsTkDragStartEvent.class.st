Class {
	#name : #VsTkDragStartEvent,
	#superclass : #VsTkAbstractDragEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkDragStartEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragStart: self
]
