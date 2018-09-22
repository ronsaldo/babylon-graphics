Class {
	#name : #CyTkMouseLeave,
	#superclass : #CyTkFocusEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkMouseLeave >> handleWith: anEventHandler [
	^ anEventHandler handleMouseLeave: anEventHandler
]
