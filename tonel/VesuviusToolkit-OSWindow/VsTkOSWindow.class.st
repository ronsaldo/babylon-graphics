Class {
	#name : #VsTkOSWindow,
	#superclass : #VsTkAbstractHostWindow,
	#traits : 'TVsTkOSWindowEventDispatcher',
	#classTraits : 'TVsTkOSWindowEventDispatcher classTrait',
	#instVars : [
		'osWindow',
		'osWindowMutex'
	],
	#category : #'VesuviusToolkit-OSWindow'
}

{ #category : #'initialize-release' }
VsTkOSWindow >> close [
	super close.
	self osWindow ifNotNil: [ :handle | handle destroy ].
	osWindow := nil
]

{ #category : #'instance creation' }
VsTkOSWindow >> createOSWindow [
	| attributes |
	attributes := OSWindowAttributes new.
	attributes extent: self extent;
		position: self position;
		visible: visible;
		windowCentered: windowCentered.
		
	self validGraphicsDriver setupOSWindowAttributes: attributes.
	
	osWindowMutex critical: [
		osWindow := self validGraphicsDriver createOSWindowAnimatedWithAttributes: attributes eventHandler: (VsTkOSWindowEventHandler new window: self).
	]

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
VsTkOSWindow >> dispatchMove: anEvent [
	osWindow ifNotNil: [ 
		position := osWindow position
	]

]

{ #category : #'oswindow event dispatching' }
VsTkOSWindow >> dispatchShown: shownEvent [
	osWindow ifNotNil: [ 
		position := osWindow position.
	].

	visible := true.
	self changed.
]

{ #category : #drawing }
VsTkOSWindow >> doFullRedraw [
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
VsTkOSWindow >> initialize [
	super initialize.
	osWindowMutex := Mutex new.
]

{ #category : #'session management' }
VsTkOSWindow >> initializeForNewSession [
	super initializeForNewSession.
	surface := nil
]

{ #category : #'instance creation' }
VsTkOSWindow >> open [
	osWindow ifNil: [ self createOSWindow ].
	self show
]

{ #category : #accessing }
VsTkOSWindow >> osWindow [
	osWindowMutex critical: [ 
		self checkSession.
		^ osWindow
	]

]

{ #category : #accessing }
VsTkOSWindow >> setMouseCapture: newMouseCaptureOwner [
	super setMouseCapture: newMouseCaptureOwner.
	osWindow ifNil: [ ^ self ].
	
	mouseCaptureOwner ifNotNil: [ osWindow captureMouse ] ifNil: [ osWindow releaseMouse ]
]

{ #category : #accessing }
VsTkOSWindow >> setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost [
	super setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost.
	osWindow ifNil: [ ^ self ].
	
	captureHost ifTrue: [ osWindow captureMouse ] ifFalse: [ osWindow releaseMouse ]
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

{ #category : #accessing }
VsTkOSWindow >> visible: aBoolean [
	super visible: aBoolean.
	self osWindow ifNotNil: [:handle |
		aBoolean ifTrue: [ handle show ] ifFalse: [ handle hide ]
	].
]
