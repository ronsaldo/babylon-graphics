Class {
	#name : #VsTkButton,
	#superclass : #VsTkMeshWidget,
	#instVars : [
		'label',
		'isDown'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkButton >> buildMeshContentOn: meshBuilder [
	self theme buildButton: self meshOn: meshBuilder.
]

{ #category : #focus }
VsTkButton >> canHaveKeyboardFocus [
	^ true
]

{ #category : #'events-processing' }
VsTkButton >> handleMouseButtonDown: event [
	super handleMouseButtonDown: event.
	
	event wasHandled: true.
	isDown := true.
	self changed.
	self captureMouse.
]

{ #category : #'events-processing' }
VsTkButton >> handleMouseButtonUp: event [
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
VsTkButton >> handleMouseEnter: event [
	self changed.
]

{ #category : #'events-processing' }
VsTkButton >> handleMouseLeave: event [
	self changed.
]

{ #category : #initialization }
VsTkButton >> initialize [
	super initialize.
	label := ''.
	isDown := false
]

{ #category : #accessing }
VsTkButton >> isDown [
	^ isDown
]

{ #category : #accessing }
VsTkButton >> isDown: anObject [
	isDown := anObject
]

{ #category : #accessing }
VsTkButton >> label [
	^ label
]

{ #category : #accessing }
VsTkButton >> label: anObject [
	label := anObject.
	self changed.
]

{ #category : #accessing }
VsTkButton >> minimalExtent [
	^ self theme computeButtonMinimalExtent: self
]
