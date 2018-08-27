Class {
	#name : #VsTkDragEvent,
	#superclass : #VsTkAbstractDragEvent,
	#instVars : [
		'delta'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkDragEvent >> delta [
	^ delta
]

{ #category : #accessing }
VsTkDragEvent >> delta: anObject [
	delta := anObject
]

{ #category : #'initialize-release' }
VsTkDragEvent >> handleWith: anEventHandler [
	^ anEventHandler handleDragEvent: self
]
