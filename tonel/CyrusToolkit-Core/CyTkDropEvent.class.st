Class {
	#name : #CyTkDropEvent,
	#superclass : #CyTkAbstractDragEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkDropEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDropEvent: self
]
