"
I am a virtual host window. I represent a host window that does not necessarily correspond with an actual operationg system window.
"
Class {
	#name : #CyTkVirtualHostWindow,
	#superclass : #CyTkPanelWidget,
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
	#category : #'CyrusToolkit-Core-Host'
}

{ #category : #initialization }
CyTkVirtualHostWindow class >> initialize [
	super initialize.
	DoubleClickThreshold := 500 "Windows time according https://en.wikipedia.org/wiki/Double-click [August 2018]"
]

{ #category : #accessing }
CyTkVirtualHostWindow >> beginClickAt: clickPosition [
	currentClickPosition := clickPosition.
]

{ #category : #accessing }
CyTkVirtualHostWindow >> changed [
	changed := true.
	super changed
]

{ #category : #accessing }
CyTkVirtualHostWindow >> dispatchMouseEvent: event [
	self subclassResponsibility
]

{ #category : #drawing }
CyTkVirtualHostWindow >> doFullRedraw [
	self subclassResponsibility
]

{ #category : #accessing }
CyTkVirtualHostWindow >> drawPosition [
	^ 0@0
]

{ #category : #accessing }
CyTkVirtualHostWindow >> endClickAt: clickPosition withModifiers: clickModifiers [
	| now |
	(currentClickPosition closeTo: clickPosition) ifFalse: [ ^ self ].
	
	now := Time millisecondClockValue.
	(lastClickTime isNotNil and: [ (now - lastClickTime) < DoubleClickThreshold ]) ifTrue: [ 
		self dispatchMouseEvent: (CyTkDoubleClickEvent new
			position: clickPosition;
			modifiers: clickModifiers;
			yourself).
	] ifFalse: [ 
		self dispatchMouseEvent: (CyTkClickEvent new
			position: clickPosition;
			modifiers: clickModifiers;
			yourself).	
	].
	
	lastClickTime := now

]

{ #category : #accessing }
CyTkVirtualHostWindow >> graphicsDriver [
	^ graphicsDriver
]

{ #category : #accessing }
CyTkVirtualHostWindow >> graphicsDriver: aGraphicsDriver [
	graphicsDriver := aGraphicsDriver
]

{ #category : #accessing }
CyTkVirtualHostWindow >> host [
	^ self
]

{ #category : #accessing }
CyTkVirtualHostWindow >> hostPosition [
	^ ZeroPoint
]

{ #category : #initialization }
CyTkVirtualHostWindow >> initialize [
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
CyTkVirtualHostWindow >> keyboardFocus [
	^ keyboardFocus
]

{ #category : #popup }
CyTkVirtualHostWindow >> killPopUp: aWidget [
	self assert: aWidget parent isNotNil.
	aWidget parent remove: aWidget.
]

{ #category : #accessing }
CyTkVirtualHostWindow >> mouseCaptureOwner [
	^ mouseCaptureOwner
]

{ #category : #accessing }
CyTkVirtualHostWindow >> mouseFocus [
	^ mouseFocus
]

{ #category : #popup }
CyTkVirtualHostWindow >> popUp: widget at: aPosition [
	self assert: widget parent isNil.
	widget prepareToPopUpIn: self.
	self add: widget.
	widget position: aPosition.
]

{ #category : #initialization }
CyTkVirtualHostWindow >> setKeyboardFocus: widget [
	widget == keyboardFocus ifTrue: [ ^ self ].
	
	keyboardFocus ifNotNil: [
		keyboardFocus
			hasKeyboardFocus: false;
			processEvent: CyTkGotFocus new
	].
	widget ifNotNil: [
		widget
			hasKeyboardFocus: true;
			processEvent: CyTkLostFocus new
	].

	keyboardFocus := widget.
]

{ #category : #accessing }
CyTkVirtualHostWindow >> setMouseCapture: newMouseCaptureOwner [
	mouseCaptureOwner := newMouseCaptureOwner.
]

{ #category : #accessing }
CyTkVirtualHostWindow >> setMouseCapture: newMouseCaptureOwner captureHost: newCaptureHost [
	mouseCaptureOwner := newMouseCaptureOwner.
	captureHost := newCaptureHost.
]

{ #category : #focus }
CyTkVirtualHostWindow >> setMouseFocus: widget [
	widget == mouseFocus ifTrue: [ ^ self ].
	mouseFocus ifNotNil: [
		mouseFocus
			hasMouseFocus: false;
			processEvent: CyTkMouseLeave new
	].
	widget ifNotNil: [
		widget
			hasMouseFocus: true;
			processEvent: CyTkMouseEnter new
	].

	mouseFocus := widget.
]

{ #category : #accessing }
CyTkVirtualHostWindow >> surfaceExtent [
	^ self extent asIntegerPoint
]

{ #category : #accessing }
CyTkVirtualHostWindow >> validGraphicsDriver [
	^ graphicsDriver ifNil: [ graphicsDriver := BabylonDriver current ]
]

{ #category : #accessing }
CyTkVirtualHostWindow >> windowCentered [
	^ windowCentered
]

{ #category : #accessing }
CyTkVirtualHostWindow >> windowCentered: anObject [
	windowCentered := anObject
]
