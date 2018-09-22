Class {
	#name : #CyTkDoubleClickEvent,
	#superclass : #CyTkClickEvent,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
CyTkDoubleClickEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDoubleClick: self
]
