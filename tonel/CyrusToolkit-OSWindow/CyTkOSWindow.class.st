Class {
	#name : #CyTkOSWindow,
	#superclass : #CyTkAbstractHostWindow,
	#traits : 'TCyTkOSWindowEventDispatcher',
	#classTraits : 'TCyTkOSWindowEventDispatcher classTrait',
	#instVars : [
		'osWindow',
		'osWindowMutex'
	],
	#category : #'CyrusToolkit-OSWindow'
}

{ #category : #'initialize-release' }
CyTkOSWindow >> close [
	super close.
	self osWindow ifNotNil: [ :handle | handle destroy ].
	osWindow := nil
]

{ #category : #'instance creation' }
CyTkOSWindow >> createOSWindow [
	| attributes |
	attributes := OSWindowAttributes new.
	attributes extent: self extent;
		position: self position;
		visible: visible;
		windowCentered: windowCentered.
		
	self validGraphicsDriver setupOSWindowAttributes: attributes.
	
	osWindowMutex critical: [
		osWindow := self validGraphicsDriver createOSWindowAnimatedWithAttributes: attributes eventHandler: (CyTkOSWindowEventHandler new window: self).
	]

]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchExposed: exposedEvent [
	self changed.
	self doFullRedraw
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchFrame: frameEvent [
	changed ifTrue: [ self doFullRedraw. ]
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchHidden: shownEvent [
	visible := false.
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchKeyDownEvent: osEvent [
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
CyTkOSWindow >> dispatchKeyUpEvent: osEvent [
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
CyTkOSWindow >> dispatchMouseButtonPressEvent: osEvent [
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
CyTkOSWindow >> dispatchMouseButtonReleaseEvent: osEvent [
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
CyTkOSWindow >> dispatchMouseMoveEvent: osEvent [
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
CyTkOSWindow >> dispatchMouseWheelEvent: osEvent [
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
CyTkOSWindow >> dispatchMove: anEvent [
	osWindow ifNotNil: [ 
		position := osWindow position
	]

]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchShown: shownEvent [
	osWindow ifNotNil: [ 
		position := osWindow position.
	].

	visible := true.
	self changed.
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> dispatchTextInputEvent: osEvent [
	| event |
	event := CyTkTextInputEvent new
		text: osEvent text;
		yourself.
	self dispatchKeyboardEvent: event
]

{ #category : #drawing }
CyTkOSWindow >> doFullRedraw [
	osWindowMutex critical: [ 
		self checkSession.
		(osWindow isNil or: [osWindow isVisible not]) ifTrue: [ ^ self ].
		self checkSurface.
		
		surface drawToOSWindow: osWindow during: [ :canvas |
			canvas clear: Color transparent.
			self fullDrawOn: canvas
		].

		changed := false
	].

]

{ #category : #initialization }
CyTkOSWindow >> initialize [
	super initialize.
	osWindowMutex := Mutex new.
]

{ #category : #'session management' }
CyTkOSWindow >> initializeForNewSession [
	super initializeForNewSession.
	surface := nil
]

{ #category : #'instance creation' }
CyTkOSWindow >> open [
	osWindow ifNil: [ self createOSWindow ].
	self show
]

{ #category : #accessing }
CyTkOSWindow >> osWindow [
	osWindowMutex critical: [ 
		self checkSession.
		^ osWindow
	]

]

{ #category : #accessing }
CyTkOSWindow >> setMouseCapture: newMouseCaptureOwner [
	super setMouseCapture: newMouseCaptureOwner.
	osWindow ifNil: [ ^ self ].
	
	mouseCaptureOwner ifNotNil: [ osWindow captureMouse ] ifNil: [ osWindow releaseMouse ]
]

{ #category : #accessing }
CyTkOSWindow >> setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost [
	super setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost.
	osWindow ifNil: [ ^ self ].
	
	captureHost ifTrue: [ osWindow captureMouse ] ifFalse: [ osWindow releaseMouse ]
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> translateModifiers: modifiers [
	^ modifiers
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> translateMouseButton: aButton [
	^ aButton
]

{ #category : #'oswindow event dispatching' }
CyTkOSWindow >> translateMouseButtonState: aButtonState [
	^ aButtonState
]

{ #category : #accessing }
CyTkOSWindow >> visible: aBoolean [
	super visible: aBoolean.
	self osWindow ifNotNil: [:handle |
		aBoolean ifTrue: [ handle show ] ifFalse: [ handle hide ]
	].
]
