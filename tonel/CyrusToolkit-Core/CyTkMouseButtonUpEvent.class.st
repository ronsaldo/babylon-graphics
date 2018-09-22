Class {
	#name : #CyTkMouseButtonUpEvent,
	#superclass : #CyTkMouseButtonEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkMouseButtonUpEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseButtonUp: self
]
