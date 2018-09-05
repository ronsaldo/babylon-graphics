"
I am a virtual host window. I represent a host window that does not necessarily correspond with an actual operationg system window.
"
Class {
	#name : #VsTkVirtualHostWindow,
	#superclass : #VsTkPanelWidget,
	#instVars : [
		'windowCentered',
		'graphicsDriver',
		'changed',
		'keyboardFocus',
		'mouseFocus',
		'mouseCaptureOwner',
		'captureHost',
		'currentClickPosition',
		'lastClickTime'
	],
	#classVars : [
		'DoubleClickThreshold'
	],
	#category : #'VesuviusToolkit-Core-Host'
}

{ #category : #initialization }
VsTkVirtualHostWindow class >> initialize [
	super initialize.
	DoubleClickThreshold := 500 "Windows time according https://en.wikipedia.org/wiki/Double-click [August 2018]"
]

{ #category : #accessing }
VsTkVirtualHostWindow >> beginClickAt: clickPosition [
	currentClickPosition := clickPosition.
]

{ #category : #accessing }
VsTkVirtualHostWindow >> changed [
	changed := true.
	super changed
]

{ #category : #accessing }
VsTkVirtualHostWindow >> dispatchMouseEvent: event [
	self subclassResponsibility
]

{ #category : #drawing }
VsTkVirtualHostWindow >> doFullRedraw [
	self subclassResponsibility
]

{ #category : #accessing }
VsTkVirtualHostWindow >> drawPosition [
	^ 0@0
]

{ #category : #accessing }
VsTkVirtualHostWindow >> endClickAt: clickPosition withModifiers: clickModifiers [
	| now |
	(currentClickPosition closeTo: clickPosition) ifFalse: [ ^ self ].
	
	now := Time millisecondClockValue.
	(lastClickTime isNotNil and: [ (now - lastClickTime) < DoubleClickThreshold ]) ifTrue: [ 
		self dispatchMouseEvent: (VsTkDoubleClickEvent new
			position: clickPosition;
			modifiers: clickModifiers;
			yourself).
	] ifFalse: [ 
		self dispatchMouseEvent: (VsTkClickEvent new
			position: clickPosition;
			modifiers: clickModifiers;
			yourself).	
	].
	
	lastClickTime := now

]

{ #category : #accessing }
VsTkVirtualHostWindow >> graphicsDriver [
	^ graphicsDriver
]

{ #category : #accessing }
VsTkVirtualHostWindow >> graphicsDriver: aGraphicsDriver [
	graphicsDriver := aGraphicsDriver
]

{ #category : #accessing }
VsTkVirtualHostWindow >> host [
	^ self
]

{ #category : #accessing }
VsTkVirtualHostWindow >> hostPosition [
	^ ZeroPoint
]

{ #category : #initialization }
VsTkVirtualHostWindow >> initialize [
	super initialize.
	self extent: 640@480.
	self backgroundColor: Color white.
	windowCentered := true.
	changed := true.
	self meshScope: true.
	keyboardFocus := nil.
	mouseFocus := nil.
	mouseCaptureOwner := nil.
	captureHost := false.
]

{ #category : #accessing }
VsTkVirtualHostWindow >> keyboardFocus [
	^ keyboardFocus
]

{ #category : #popup }
VsTkVirtualHostWindow >> killPopUp: aWidget [
	self assert: aWidget parent isNotNil.
	aWidget parent remove: aWidget.
]

{ #category : #accessing }
VsTkVirtualHostWindow >> mouseCaptureOwner [
	^ mouseCaptureOwner
]

{ #category : #accessing }
VsTkVirtualHostWindow >> mouseFocus [
	^ mouseFocus
]

{ #category : #popup }
VsTkVirtualHostWindow >> popUp: widget at: aPosition [
	self assert: widget parent isNil.
	widget prepareToPopUpIn: self.
	self add: widget.
	widget position: aPosition.
]

{ #category : #initialization }
VsTkVirtualHostWindow >> setKeyboardFocus: widget [
	widget == keyboardFocus ifTrue: [ ^ self ].
	
	keyboardFocus ifNotNil: [
		keyboardFocus
			hasKeyboardFocus: false;
			processEvent: VsTkGotFocus new
	].
	widget ifNotNil: [
		widget
			hasKeyboardFocus: true;
			processEvent: VsTkLostFocus new
	].

	keyboardFocus := widget.
]

{ #category : #accessing }
VsTkVirtualHostWindow >> setMouseCapture: newMouseCaptureOwner [
	mouseCaptureOwner := newMouseCaptureOwner.
]

{ #category : #accessing }
VsTkVirtualHostWindow >> setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost [
	mouseCaptureOwner := newMouseCaptureOwner.
	captureHost := newCaptureHost.
]

{ #category : #focus }
VsTkVirtualHostWindow >> setMouseFocus: widget [
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

{ #category : #accessing }
VsTkVirtualHostWindow >> surfaceExtent [
	^ self extent asIntegerPoint
]

{ #category : #accessing }
VsTkVirtualHostWindow >> validGraphicsDriver [
	^ graphicsDriver ifNil: [ graphicsDriver := PompeiiDriver current ]
]

{ #category : #accessing }
VsTkVirtualHostWindow >> windowCentered [
	^ windowCentered
]

{ #category : #accessing }
VsTkVirtualHostWindow >> windowCentered: anObject [
	windowCentered := anObject
]
