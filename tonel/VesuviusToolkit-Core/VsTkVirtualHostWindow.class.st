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
		'captureHost'
	],
	#category : #'VesuviusToolkit-Core-Host'
}

{ #category : #accessing }
VsTkVirtualHostWindow >> changed [
	changed := true.
	super changed
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

{ #category : #accessing }
VsTkVirtualHostWindow >> mouseCaptureOwner [
	^ mouseCaptureOwner
]

{ #category : #accessing }
VsTkVirtualHostWindow >> mouseFocus [
	^ mouseFocus
]

{ #category : #focus }
VsTkVirtualHostWindow >> setKeyboardFocus: widget [
	widget == keyboardFocus ifTrue: [ ^ self ].
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
