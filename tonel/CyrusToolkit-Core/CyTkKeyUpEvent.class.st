Class {
	#name : #CyTkKeyUpEvent,
	#superclass : #CyTkKeyEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkKeyUpEvent >> handleWith: anEventHandler [
	^ anEventHandler handleKeyUp: self
]
