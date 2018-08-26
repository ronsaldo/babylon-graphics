"
I represent a theme of the vesubius toolkit.
"
Class {
	#name : #VsTkTheme,
	#superclass : #Object,
	#classVars : [
		'CurrentTheme'
	],
	#category : #'VesuviusToolkit-Core-Theme'
}

{ #category : #accessing }
VsTkTheme class >> current [
	^ CurrentTheme ifNil: [ CurrentTheme := VsTkBasicTheme new  ]
]

{ #category : #accessing }
VsTkTheme class >> current: aTheme [
	CurrentTheme := aTheme
]

{ #category : #'mesh widgets' }
VsTkTheme >> buildButton: button meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> buildLabel: label meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> buildMenuBar: menuBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> buildStatusBar: statusBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> buildToolBar: toolBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> computeButtonMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> computeLabelMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> computeMenuBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> computeStatusBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
VsTkTheme >> computeToolBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
VsTkTheme >> extentOfText: aText withFont: aFont [
	^ (aFont widthOfString: aText) @ (aFont getPreciseAscent + aFont getPreciseDescent)
]

{ #category : #'as yet unclassified' }
VsTkTheme >> widthOfText: aText withFont: aFont [
	^ aFont widthOfString: aText
]
