Class {
	#name : #CyTkDragStartEvent,
	#superclass : #CyTkAbstractDragEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkDragStartEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragStart: self
]
