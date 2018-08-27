Class {
	#name : #VsTkDoubleClickEvent,
	#superclass : #VsTkClickEvent,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'initialize-release' }
VsTkDoubleClickEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDoubleClick: self
]
