Class {
	#name : #CyTkDragState,
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
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #initialization }
CyTkDragState class >> initialize [
	DragStartThreshold := 2
]

{ #category : #'events-processing' }
CyTkDragState >> beginDragging [
	| event |
	isDragging := true.
	event := CyTkDragStartEvent new
		initialButton: initialButton;
		buttonState: initialButtonState;
		modifiers: initialModifiers;
		position: initialPosition;
		yourself.
	widget processEvent: event.
	
	event := CyTkDragEvent new
		initialButton: initialButton;
		buttonState: currentButtonState;
		modifiers: currentModifiers;
		position: currentPosition;
		delta: currentPosition - initialPosition;
		yourself.
	widget processEvent: event.
]

{ #category : #'events-processing' }
CyTkDragState >> finishDragging [
	| event |
	isDragging ifTrue: [ 
		event := CyTkDragEndEvent new
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
CyTkDragState >> handleMouseButtonDown: event [
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
CyTkDragState >> handleMouseButtonUp: event [
	currentButtonState := event buttonState.
	currentPosition := event position.
	currentModifiers := event modifiers.
	
	event button = initialButton ifTrue: [
		currentPosition := event position.
		self finishDragging
	].

]

{ #category : #'events-processing' }
CyTkDragState >> handleMouseMove: event [
	| dragEvent |
	currentPosition := event position.	
	currentButtonState := event buttonState.
	currentModifiers := event modifiers.
	
	isDragging ifTrue: [ 
		dragEvent := CyTkDragEvent new
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
CyTkDragState >> initialize [
	super initialize.
	isDragging := false.
]

{ #category : #accessing }
CyTkDragState >> widget [
	^ widget
]

{ #category : #accessing }
CyTkDragState >> widget: anObject [
	widget := anObject
]
