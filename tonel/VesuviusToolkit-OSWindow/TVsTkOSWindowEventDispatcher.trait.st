Trait {
	#name : #TVsTkOSWindowEventDispatcher,
	#category : #'VesuviusToolkit-OSWindow'
}

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchKeyDownEvent: osEvent [
	| event |
	event := VsTkKeyDownEvent new.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchKeyUpEvent: anEvent [
	| event |
	event := VsTkKeyUpEvent new.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchKeyboardEvent: anEvent [
	| currentWidget |
	currentWidget := self keyboardFocus ifNil: [ self ].
	[ currentWidget isNotNil and: [ anEvent skipPropagation not ] ] whileTrue: [
		currentWidget processEvent: anEvent.
		currentWidget := currentWidget parent
	]
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseButtonPressEvent: osEvent [
	| event |
	event := VsTkMouseButtonDownEvent new
		position: osEvent position;
		button: (self translateMouseButton: osEvent button);
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
	
	self dispatchMouseEvent: event.
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseButtonReleaseEvent: osEvent [
	| event |
	event := VsTkMouseButtonUpEvent new
		position: osEvent position;
		button: (self translateMouseButton: osEvent button);
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseEvent: event [
	| oldMouseCapture result |
	[
		oldMouseCapture := self mouseCaptureOwner.

		self mouseCaptureOwner ifNil: [
			result := self processEvent: event
		] ifNotNil: [
			result := self mouseCaptureOwner processEvent: (event toLocalOrigin: self mouseCaptureOwner hostPosition) 
		]
	] doWhileTrue: [ oldMouseCapture ~~ self mouseCaptureOwner and: [ oldMouseCapture isNotNil ]].

	^ result
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseMoveEvent: osEvent [
	| event |
	event := VsTkMouseMoveEvent new
		position: osEvent position;
		delta: osEvent delta;
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event
	
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseWheelEvent: anEvent [
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchResize: anEvent [
	self extent: anEvent width @ anEvent height
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchTextInputEvent: osEvent [
	| event |
	event := VsTkTextInputEvent new
		text: osEvent text;
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> translateModifiers: modifiers [
	^ modifiers
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> translateMouseButton: aButton [
	^ aButton
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> translateMouseButtonState: aButtonState [
	^ aButtonState
]
