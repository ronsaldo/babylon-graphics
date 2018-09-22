Class {
	#name : #CyTkButton,
	#superclass : #CyTkMeshWidget,
	#instVars : [
		'label',
		'isDown'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkButton >> buildMeshContentOn: meshBuilder [
	self theme buildButton: self meshOn: meshBuilder.
]

{ #category : #focus }
CyTkButton >> canHaveKeyboardFocus [
	^ true
]

{ #category : #'events-processing' }
CyTkButton >> handleMouseButtonDown: event [
	super handleMouseButtonDown: event.
	
	event wasHandled: true.
	isDown := true.
	self changed.
	self captureMouse.
]

{ #category : #'events-processing' }
CyTkButton >> handleMouseButtonUp: event [
	super handleMouseButtonDown: event.
	
	event wasHandled: true.
	isDown := false.
	self changed.
	self releaseMouse.
	
	(self hostBounds containsPoint: event position) ifTrue: [
		self fireActionEvent
	]
]

{ #category : #'events-processing' }
CyTkButton >> handleMouseEnter: event [
	self changed.
]

{ #category : #'events-processing' }
CyTkButton >> handleMouseLeave: event [
	self changed.
]

{ #category : #initialization }
CyTkButton >> initialize [
	super initialize.
	label := ''.
	isDown := false
]

{ #category : #accessing }
CyTkButton >> isDown [
	^ isDown
]

{ #category : #accessing }
CyTkButton >> isDown: anObject [
	isDown := anObject
]

{ #category : #accessing }
CyTkButton >> label [
	^ label
]

{ #category : #accessing }
CyTkButton >> label: anObject [
	label := anObject.
	self changed.
]

{ #category : #accessing }
CyTkButton >> minimalExtent [
	^ self theme computeButtonMinimalExtent: self
]
