Class {
	#name : #CyTkMouseEnter,
	#superclass : #CyTkFocusEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkMouseEnter >> handleWith: anEventHandler [
	^ anEventHandler handleMouseEnter: anEventHandler
]
