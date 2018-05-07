Class {
	#name : #VsTkActionEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'source'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkActionEvent class >> source: aSource [
	^ self new source: aSource
]

{ #category : #'initialize-release' }
VsTkActionEvent >> handleWith: anEventHandler [
	^ anEventHandler handleActionEvent: self
]

{ #category : #accessing }
VsTkActionEvent >> source [
	^ source
]

{ #category : #accessing }
VsTkActionEvent >> source: anObject [
	source := anObject
]
