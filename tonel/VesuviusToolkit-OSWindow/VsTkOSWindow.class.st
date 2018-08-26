Class {
	#name : #VsTkOSWindow,
	#superclass : #VsTkPanelWidget,
	#instVars : [
		'osWindow',
		'windowCentered',
		'session',
		'surface',
		'graphicsDriver',
		'changed',
		'keyboardFocus',
		'mouseFocus',
		'mouseCaptureOwner',
		'captureHost'
	],
	#category : #'VesuviusToolkit-OSWindow'
}

{ #category : #accessing }
VsTkOSWindow >> changed [
	changed := true.
	super changed
]

{ #category : #'session management' }
VsTkOSWindow >> checkSession [
	session ~~ Smalltalk session ifTrue: [
		osWindow := nil.
		surface := nil.
	].

]

{ #category : #'session management' }
VsTkOSWindow >> checkSurface [
	(surface isNotNil and: [ surface extent = self surfaceExtent ]) ifTrue: [ ^ self ].
	surface ifNil: [ 
		graphicsDriver := PompeiiDriver current.
		surface := graphicsDriver surfaceWithExtent: self surfaceExtent asIntegerPoint.
	].

	surface extent: self surfaceExtent.
]

{ #category : #'initialize-release' }
VsTkOSWindow >> close [
	surface destroy.
	self osWindow ifNotNil: [ :handle | handle destroy ].
	osWindow := nil
]

{ #category : #'instance creation' }
VsTkOSWindow >> createOSWindow [
	| attributes |
	attributes := OSWindowAttributes new.
	attributes extent: self extent;
		position: self position;
		visible: false;
		windowCentered: windowCentered.
		
	self validGraphicsDriver setupOSWindowAttributes: attributes.
	
	osWindow := self validGraphicsDriver createOSWindowAnimatedWithAttributes: attributes eventHandler: (VsTkOSWindowEventHandler new window: self).
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchExposed: exposedEvent [
	self changed.
	self doFullRedraw
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchFrame: frameEvent [
	changed ifTrue: [ self doFullRedraw. ]
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchHidden: shownEvent [
	visible := false.
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchKeyDownEvent: osEvent [
	| event |
	event := VsTkKeyDownEvent new.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchKeyUpEvent: anEvent [
	| event |
	event := VsTkKeyUpEvent new.
	self dispatchKeyboardEvent: event
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchKeyboardEvent: anEvent [
	| currentWidget |
	currentWidget := keyboardFocus ifNil: [ self ].
	[ currentWidget isNotNil and: [ anEvent skipPropagation not ] ] whileTrue: [
		currentWidget processEvent: anEvent.
		currentWidget := currentWidget parent
	]
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchMouseButtonPressEvent: osEvent [
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
VsTkOSWindow >> dispatchMouseButtonReleaseEvent: osEvent [
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
VsTkOSWindow >> dispatchMouseEvent: event [
	| oldMouseCapture result |
	[
		oldMouseCapture := mouseCaptureOwner.

		mouseCaptureOwner ifNil: [
			result := self processEvent: event
		] ifNotNil: [
			result := mouseCaptureOwner processEvent: (event toLocalOrigin: mouseCaptureOwner hostPosition) 
		]
	] doWhileTrue: [ oldMouseCapture ~~ mouseCaptureOwner and: [ oldMouseCapture isNotNil ]].

	^ result
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchMouseMoveEvent: osEvent [
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
VsTkOSWindow >> dispatchMouseWheelEvent: anEvent [
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchMove: anEvent [
	osWindow ifNotNil: [ 
		position := osWindow position
	]

]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchResize: anEvent [
	extent := anEvent width @ anEvent height.
	self boundsChanged.
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchShown: shownEvent [
	osWindow ifNotNil: [ 
		position := osWindow position.
	].

	visible := true.
	self changed.
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchTextInputEvent: osEvent [
	| event |
	event := VsTkTextInputEvent new
		text: osEvent text;
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #drawing }
VsTkOSWindow >> doFullRedraw [
	self checkSession.
	(osWindow isNil or: [osWindow isVisible not]) ifTrue: [ ^ self ].
	self checkSurface.
	
	surface drawToOSWindow: osWindow during: [ :canvas |
		canvas clear: Color transparent.
		self fullDrawOn: canvas
	].

	changed := false
]

{ #category : #accessing }
VsTkOSWindow >> drawPosition [
	^ 0@0
]

{ #category : #accessing }
VsTkOSWindow >> graphicsDriver [
	^ graphicsDriver
]

{ #category : #accessing }
VsTkOSWindow >> host [
	^ self
]

{ #category : #accessing }
VsTkOSWindow >> hostPosition [
	^ ZeroPoint
]

{ #category : #initialization }
VsTkOSWindow >> initialize [
	super initialize.
	self extent: 640@480.
	self backgroundColor: Color white.
	windowCentered := true.
	session := Smalltalk session.
	changed := true.
	self meshScope: true.
	keyboardFocus := nil.
	mouseFocus := nil.
	mouseCaptureOwner := nil.
	captureHost := false.
]

{ #category : #'instance creation' }
VsTkOSWindow >> open [
	osWindow ifNil: [ self createOSWindow ].
	self show
]

{ #category : #accessing }
VsTkOSWindow >> osWindow [
	self checkSession.
	^ osWindow
]

{ #category : #focus }
VsTkOSWindow >> setKeyboardFocus: widget [
	widget == keyboardFocus ifTrue: [ ^ self ].
]

{ #category : #initialization }
VsTkOSWindow >> setMouseCapture: newMouseCaptureOwner [
	mouseCaptureOwner := newMouseCaptureOwner.
	osWindow ifNil: [ ^ self ].
	
	mouseCaptureOwner ifNotNil: [ osWindow captureMouse ] ifNil: [ osWindow releaseMouse ]
]

{ #category : #initialization }
VsTkOSWindow >> setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost [
	mouseCaptureOwner := newMouseCaptureOwner.
	captureHost := newCaptureHost.
	osWindow ifNil: [ ^ self ].
	
	captureHost ifTrue: [ osWindow captureMouse ] ifFalse: [ osWindow releaseMouse ]
]

{ #category : #focus }
VsTkOSWindow >> setMouseFocus: widget [
	widget == mouseFocus ifTrue: [ ^ self ].
	mouseFocus ifNotNil: [
		mouseFocus
			hasMouseFocus: false;
			processEvent: VsTkMouseLeave new
	].
	widget ifNotNil: [
		widget
			hasMouseFocus: true;
			processEvent: VsTkMouseEnter new
	].

	mouseFocus := widget.
]

{ #category : #'as yet unclassified' }
VsTkOSWindow >> surfaceExtent [
	^ self extent asIntegerPoint
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> translateModifiers: modifiers [
	^ modifiers
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> translateMouseButton: aButton [
	^ aButton
]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> translateMouseButtonState: aButtonState [
	^ aButtonState
]

{ #category : #'as yet unclassified' }
VsTkOSWindow >> validGraphicsDriver [
	^ graphicsDriver ifNil: [ PompeiiDriver current ]
]

{ #category : #accessing }
VsTkOSWindow >> visible: aBoolean [
	super visible: aBoolean.
	self osWindow ifNotNil: [:handle |
		aBoolean ifTrue: [ handle show ] ifFalse: [ handle hide ]
	].
]

{ #category : #accessing }
VsTkOSWindow >> windowCentered [
	^ windowCentered
]

{ #category : #accessing }
VsTkOSWindow >> windowCentered: anObject [
	windowCentered := anObject
]
