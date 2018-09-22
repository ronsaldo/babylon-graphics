Class {
	#name : #CyTkMouseButtonDownEvent,
	#superclass : #CyTkMouseButtonEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkMouseButtonDownEvent >> handleWith: anEventHandler [
	^ anEventHandler handleMouseButtonDown: self
]
