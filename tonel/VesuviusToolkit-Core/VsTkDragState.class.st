Class {
	#name : #VsTkDragState,
	#superclass : #Object,
	#instVars : [
		'widget',
		'initialButton',
		'initialPosition',
		'isDragging',
		'currentPosition',
		'initialModifiers',
		'currentModifiers',
		'initialButtonState',
		'currentButtonState'
	],
	#classVars : [
		'DragStartThreshold'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #initialization }
VsTkDragState class >> initialize [
	DragStartThreshold := 2
]

{ #category : #'events-processing' }
VsTkDragState >> beginDragging [
	| event |
	isDragging := true.
	event := VsTkDragStartEvent new
		initialButton: initialButton;
		buttonState: initialButtonState;
		modifiers: initialModifiers;
		position: initialPosition;
		yourself.
	widget processEvent: event.
	
	event := VsTkDragEvent new
		initialButton: initialButton;
		buttonState: currentButtonState;
		modifiers: currentModifiers;
		position: currentPosition;
		delta: currentPosition - initialPosition;
		yourself.
	widget processEvent: event.
]

{ #category : #'events-processing' }
VsTkDragState >> finishDragging [
	| event |
	isDragging ifTrue: [ 
		event := VsTkDragEndEvent new
			initialButton: initialButton;
			buttonState: currentButtonState;
			modifiers: currentModifiers;
			position: currentPosition;
			yourself.
		widget processEvent: event.
	].

	widget dragState: nil
]

{ #category : #'events-processing' }
VsTkDragState >> handleMouseButtonDown: event [
	currentButtonState := event buttonState.
	currentPosition := event position.
	currentModifiers := event modifiers.

	initialButton ifNil: [
		initialButton := event button.
		initialButtonState := event buttonState.
		initialPosition := event position.
		initialModifiers := event modifiers.

		widget dragState: self
	].

]

{ #category : #'events-processing' }
VsTkDragState >> handleMouseButtonUp: event [
	currentButtonState := event buttonState.
	currentPosition := event position.
	currentModifiers := event modifiers.
	
	event button = initialButton ifTrue: [
		currentPosition := event position.
		self finishDragging
	].

]

{ #category : #'events-processing' }
VsTkDragState >> handleMouseMove: event [
	| dragEvent |
	currentPosition := event position.	
	currentButtonState := event buttonState.
	currentModifiers := event modifiers.
	
	isDragging ifTrue: [ 
		dragEvent := VsTkDragEvent new
			initialButton: initialButton;
			buttonState: currentButtonState;
			modifiers: currentModifiers;
			position: currentPosition;
			delta: event delta;
			yourself.
		widget processEvent: dragEvent
	] ifFalse: [ 
		(currentPosition squaredDistanceTo: initialPosition) >= (DragStartThreshold * DragStartThreshold) ifTrue: [ 
			self beginDragging.
		]
	].



]

{ #category : #initialization }
VsTkDragState >> initialize [
	super initialize.
	isDragging := false.
]

{ #category : #accessing }
VsTkDragState >> widget [
	^ widget
]

{ #category : #accessing }
VsTkDragState >> widget: anObject [
	widget := anObject
]
