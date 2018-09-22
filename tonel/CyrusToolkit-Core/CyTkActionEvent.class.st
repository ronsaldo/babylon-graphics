Class {
	#name : #CyTkActionEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'source'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkActionEvent class >> source: aSource [
	^ self new source: aSource
]

{ #category : #'initialize-release' }
CyTkActionEvent >> handleWith: anEventHandler [
	^ anEventHandler handleActionEvent: self
]

{ #category : #accessing }
CyTkActionEvent >> source [
	^ source
]

{ #category : #accessing }
CyTkActionEvent >> source: anObject [
	source := anObject
]
