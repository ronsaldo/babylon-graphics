Class {
	#name : #CyTkOSWindowEventHandler,
	#superclass : #OSWindowEventVisitor,
	#instVars : [
		'window'
	],
	#category : #'CyrusToolkit-OSWindow'
}

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitKeyDownEvent: anEvent [
	window ifNotNil: [ window dispatchKeyDownEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitKeyUpEvent: anEvent [
	window ifNotNil: [ window dispatchKeyUpEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitMouseButtonPressEvent: anEvent [
	window ifNotNil: [ window dispatchMouseButtonPressEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitMouseButtonReleaseEvent: anEvent [
	window ifNotNil: [ window dispatchMouseButtonReleaseEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitMouseMoveEvent: anEvent [
	window ifNotNil: [ window dispatchMouseMoveEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitMouseWheelEvent: anEvent [
	window ifNotNil: [ window dispatchMouseWheelEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitTextInputEvent: anEvent [
	window ifNotNil: [ window dispatchTextInputEvent: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowCloseEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window close ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowExposeEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchExposed: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowFrameEvent: anEvent [
	window ifNotNil: [ window dispatchFrame: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowHiddenEvent: anEvent [
	Transcript show: 'Hidden'; cr.
	window ifNotNil: [ window dispatchHidden: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowMoveEvent: anEvent [
	window ifNotNil: [ window dispatchMove: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowResizeEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchResize: anEvent ]
]

{ #category : #visiting }
CyTkOSWindowEventHandler >> visitWindowShownEvent: anEvent [
	anEvent suppressDefaultAction.
	window ifNotNil: [ window dispatchShown: anEvent ]
]

{ #category : #accessing }
CyTkOSWindowEventHandler >> window [
	^ window
]

{ #category : #accessing }
CyTkOSWindowEventHandler >> window: anObject [
	window := anObject
]
