Class {
	#name : #CyTkKeyDownEvent,
	#superclass : #CyTkKeyEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkKeyDownEvent >> handleWith: anEventHandler [
	^ anEventHandler handleKeyDown: self
]
