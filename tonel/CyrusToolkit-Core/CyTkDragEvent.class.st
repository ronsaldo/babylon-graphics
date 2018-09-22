Class {
	#name : #CyTkDragEvent,
	#superclass : #CyTkAbstractDragEvent,
	#instVars : [
		'delta'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkDragEvent >> delta [
	^ delta
]

{ #category : #accessing }
CyTkDragEvent >> delta: anObject [
	delta := anObject
]

{ #category : #'initialize-release' }
CyTkDragEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragEvent: self
]
