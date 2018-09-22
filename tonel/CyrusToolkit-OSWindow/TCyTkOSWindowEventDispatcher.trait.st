Trait {
	#name : #TCyTkOSWindowEventDispatcher,
	#category : #'CyrusToolkit-OSWindow'
}

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchKeyDownEvent: osEvent [
	| event |
	event := CyTkKeyDownEvent new
		symbol: osEvent symbol;
		scanCode: osEvent scanCode;
		repeat: osEvent repeat;
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchKeyUpEvent: osEvent [
	| event |
	event := CyTkKeyUpEvent new
		symbol: osEvent symbol;
		scanCode: osEvent scanCode;
		repeat: osEvent repeat;
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchKeyboardEvent: anEvent [
	| currentWidget |
	currentWidget := self keyboardFocus ifNil: [ self ].
	[ currentWidget isNotNil and: [ anEvent skipPropagation not ] ] whileTrue: [
		currentWidget processEvent: anEvent.
		currentWidget := currentWidget parent
	]
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchMouseButtonPressEvent: osEvent [
	| event |
	event := CyTkMouseButtonDownEvent new
		position: osEvent position;
		button: (self translateMouseButton: osEvent button);
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
	
	osEvent button = 1 ifTrue: [ self beginClickAt: osEvent position ].
	self dispatchMouseEvent: event.
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchMouseButtonReleaseEvent: osEvent [
	| event |
	event := CyTkMouseButtonUpEvent new
		position: osEvent position;
		button: (self translateMouseButton: osEvent button);
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event.
	
	osEvent button = 1 ifTrue: [ self endClickAt: osEvent position withModifiers: osEvent modifiers ].
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchMouseEvent: event [
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
TCyTkOSWindowEventDispatcher >> dispatchMouseMoveEvent: osEvent [
	| event |
	event := CyTkMouseMoveEvent new
		position: osEvent position;
		delta: osEvent delta;
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event
	
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchMouseWheelEvent: osEvent [
	| event |
	event := CyTkMouseWheelEvent new
		position: osEvent position;
		scrollHorizontal: osEvent scrollHorizontal;
		scrollVertical: osEvent scrollVertical;
		buttonState: (self translateMouseButtonState: osEvent modifiers);
		modifiers: (self translateModifiers: osEvent modifiers);
		yourself.
		
	self dispatchMouseEvent: event
	
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchResize: anEvent [
	self extent: anEvent width @ anEvent height
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> dispatchTextInputEvent: osEvent [
	| event |
	event := CyTkTextInputEvent new
		text: osEvent text;
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> translateModifiers: modifiers [
	^ modifiers
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> translateMouseButton: aButton [
	^ aButton
]

{ #category : #'oswindow event dispatching' }
TCyTkOSWindowEventDispatcher >> translateMouseButtonState: aButtonState [
	^ aButtonState
]
