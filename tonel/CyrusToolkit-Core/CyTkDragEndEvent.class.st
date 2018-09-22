Class {
	#name : #CyTkDragEndEvent,
	#superclass : #CyTkAbstractDragEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkDragEndEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragEnd: self
]
