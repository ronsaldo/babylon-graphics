"
I represent a theme of the vesubius toolkit.
"
Class {
	#name : #CyTkTheme,
	#superclass : #Object,
	#classVars : [
		'CurrentTheme'
	],
	#category : #'CyrusToolkit-Core-Theme'
}

{ #category : #accessing }
CyTkTheme class >> current [
	^ CurrentTheme ifNil: [ CurrentTheme := CyTkBasicTheme new  ]
]

{ #category : #accessing }
CyTkTheme class >> current: aTheme [
	CurrentTheme := aTheme
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildButton: button meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildLabel: label meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildMenu: menu meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildMenuBar: menuBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildMenuItem: label meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildMenuSeparator: label meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildStatusBar: statusBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> buildToolBar: toolBar meshOn: meshBuilder [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeButtonMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeLabelMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeMenuBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeMenuItemMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeMenuSeparatorMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeStatusBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'mesh widgets' }
CyTkTheme >> computeToolBarMinimalExtent: button [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
CyTkTheme >> extentOfText: aText withFont: aFont [
	^ (aFont widthOfString: aText) @ (aFont getPreciseAscent + aFont getPreciseDescent)
]

{ #category : #'mesh widgets' }
CyTkTheme >> widgetFont [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
CyTkTheme >> widthOfText: aText withFont: aFont [
	^ aFont widthOfString: aText
]
