Trait {
	#name : #TVsTkOSWindowEventDispatcher,
	#category : #'VesuviusToolkit-OSWindow'
}

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchKeyDownEvent: osEvent [
	| event |
	event := VsTkKeyDownEvent new
		symbol: osEvent symbol;
		scanCode: osEvent scanCode;
		repeat: osEvent repeat;
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchKeyUpEvent: osEvent [
	| event |
	event := VsTkKeyUpEvent new
		symbol: osEvent symbol;
		scanCode: osEvent scanCode;
		repeat: osEvent repeat;
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
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
	
	osEvent button = 1 ifTrue: [ self beginClickAt: osEvent position ].
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
		
	self dispatchMouseEvent: event.
	
	osEvent button = 1 ifTrue: [ self endClickAt: osEvent position withModifiers: osEvent modifiers ].
]

{ #category : #'oswindow event dispatching' }
TVsTkOSWindowEventDispatcher >> dispatchMouseEvent: event [
	| oldMouseCapture result |
	[
		oldMouseCapture := self mouseCaptureOwner.

		self mouseCaptureOwner ifNil: [
			result := self processEvent: event
		] ifNotNil: [
			Transcript show: 'dispatch to mouse capture.'; cr.
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
TVsTkOSWindowEventDispatcher >> dispatchMouseWheelEvent: osEvent [
	| event |
	event := VsTkMouseWheelEvent new
		position: osEvent position;
		scrollHorizontal: osEvent scrollHorizontal;
		scrollVertical: osEvent scrollVertical;
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event
	
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
