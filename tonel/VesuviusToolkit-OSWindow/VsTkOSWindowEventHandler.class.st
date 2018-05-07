Class {
	#name : #VsTkOSWindowEventHandler,
	#superclass : #OSWindowEventVisitor,
	#instVars : [
		'window'
	],
	#category : #'VesuviusToolkit-OSWindow'
}

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitKeyDownEvent: anEvent [
	window ifNotNil: [ window dispatchKeyDownEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitKeyUpEvent: anEvent [
	window ifNotNil: [ window dispatchKeyUpEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitMouseButtonPressEvent: anEvent [
	window ifNotNil: [ window dispatchMouseButtonPressEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitMouseButtonReleaseEvent: anEvent [
	window ifNotNil: [ window dispatchMouseButtonReleaseEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitMouseMoveEvent: anEvent [
	window ifNotNil: [ window dispatchMouseMoveEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitMouseWheelEvent: anEvent [
	window ifNotNil: [ window dispatchMouseWheelEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitTextInputEvent: anEvent [
	window ifNotNil: [ window dispatchTextInputEvent: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowExposeEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchExposed: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowFrameEvent: anEvent [
	window ifNotNil: [ window dispatchFrame: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowHiddenEvent: anEvent [
	Transcript show: 'Hidden'; cr.
	window ifNotNil: [ window dispatchHidden: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowMoveEvent: anEvent [
	window ifNotNil: [ window dispatchMove: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowResizeEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchResize: anEvent ]
]

{ #category : #visiting }
VsTkOSWindowEventHandler >> visitWindowShownEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchShown: anEvent ]
]

{ #category : #accessing }
VsTkOSWindowEventHandler >> window [
	^ window
]

{ #category : #accessing }
VsTkOSWindowEventHandler >> window: anObject [
	window := anObject
]
