"
I represent a basic theme in the vesubius toolkit.
"
Class {
	#name : #CyTkBasicTheme,
	#superclass : #CyTkTheme,
	#instVars : [
		'widgetFont',
		'buttonRoundRadius',
		'buttonHighlightTopColor',
		'buttonHighlightBottomColor',
		'buttonNormalTopColor',
		'buttonNormalBottomColor',
		'buttonDownTopColor',
		'buttonDownBottomColor',
		'buttonBorderWidth',
		'buttonBorderColor',
		'buttonLabelBorderExtent',
		'labelColor',
		'buttonLabelColor',
		'menuBarBackgroundColor',
		'toolBarBackgroundColor',
		'statusBarBackgroundColor',
		'menuItemLabelBorderExtent',
		'menuItemSelectionColor',
		'menuBackgroundColor',
		'menuSeparatorColor'
	],
	#category : #'CyrusToolkit-Core-Theme'
}

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildButton: button meshOn: meshBuilder [
	| topColor bottomColor bounds |
	
	button isDown ifTrue: [
		topColor := buttonDownTopColor.
		bottomColor := buttonDownBottomColor
	] ifFalse: [ 
		button hasMouseFocus ifTrue: [
			topColor := buttonHighlightTopColor.
			bottomColor := buttonHighlightBottomColor
		] ifFalse: [
			topColor := buttonNormalTopColor.
			bottomColor := buttonNormalBottomColor
		]
	].

	bounds := button localBounds.
	
	meshBuilder fill
		verticalGradientBounds: bounds start: topColor end: bottomColor;
		rectangle: bounds round: buttonRoundRadius.
	meshBuilder stroke
		color: buttonBorderColor;
		width: buttonBorderWidth;
		rectangle: bounds round: buttonRoundRadius.
	meshBuilder text
		color: buttonLabelColor;
		font: self widgetFont;
		draw: button label onRectangleCenter: bounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildLabel: label meshOn: meshBuilder [
	meshBuilder text
		color: labelColor;
		font: self widgetFont;
		draw: label text onRectangleCenterLeft: label localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildMenu: menu meshOn: meshBuilder [
	meshBuilder fill
		color: menuBackgroundColor;
		rectangle: menu localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildMenuBar: menuBar meshOn: meshBuilder [
	meshBuilder fill
		color: menuBarBackgroundColor;
		rectangle: menuBar localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildMenuItem: menuItem meshOn: meshBuilder [
	menuItem selected ifTrue: [
		meshBuilder fill
			color: menuItemSelectionColor;
			rectangle: menuItem localBounds.
	].

	meshBuilder text
		color: labelColor;
		font: self widgetFont;
		draw: menuItem label onRectangleCenter: menuItem localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildMenuSeparator: menuSeparator meshOn: meshBuilder [
	| bounds |
	bounds := menuSeparator localBounds.
	meshBuilder stroke
		color: menuSeparatorColor;
		drawLine: { bounds leftCenter . bounds rightCenter }

]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildStatusBar: statusBar meshOn: meshBuilder [
	meshBuilder fill
		color: statusBarBackgroundColor;
		rectangle: statusBar localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> buildToolBar: toolBar meshOn: meshBuilder [
	meshBuilder fill
		color: toolBarBackgroundColor;
		rectangle: toolBar localBounds
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeButtonMinimalExtent: button [
	^ buttonLabelBorderExtent + (self extentOfWidgetText: button label)
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeLabelMinimalExtent: label [
	^ self extentOfWidgetText: label text
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeMenuBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeMenuItemMinimalExtent: menuItem [
	^ menuItemLabelBorderExtent + (self extentOfWidgetText: menuItem label)
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeMenuSeparatorMinimalExtent: menuItem [
	^ 3@3
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeStatusBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> computeToolBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> extentOfWidgetText: aText [
	^ self extentOfText: aText withFont: self widgetFont
]

{ #category : #initialization }
CyTkBasicTheme >> initialize [
	super initialize.
	self setParameters.
]

{ #category : #initialization }
CyTkBasicTheme >> setParameters [
	labelColor := Color black.
	
	buttonLabelColor := Color black.
	buttonRoundRadius := 10.
	buttonBorderWidth := 2.
	buttonLabelBorderExtent := 12@12.
	buttonBorderColor := Color black alpha: 0.8.
	buttonHighlightTopColor := Color veryVeryLightGray muchLighter.
	buttonHighlightBottomColor := Color veryVeryLightGray.
	buttonNormalTopColor := Color veryLightGray muchLighter.
	buttonNormalBottomColor := Color veryLightGray.
	buttonDownTopColor := Color lightGray.
	buttonDownBottomColor := Color lightGray muchLighter.
	
	menuBarBackgroundColor := Color lightGray.
	menuBackgroundColor := Color lightGray.
	menuSeparatorColor := Color veryVeryDarkGray.
	menuItemLabelBorderExtent := 12@12.
	menuItemSelectionColor := Color blue lighter lighter lighter.
	
	toolBarBackgroundColor := Color lightGray lighter.
	statusBarBackgroundColor := Color lightGray lighter.

]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> widgetFont [
	^ widgetFont ifNil: [ widgetFont := LogicalFont familyName: 'Arial' pointSize: 20 ]
]

{ #category : #'mesh widgets' }
CyTkBasicTheme >> widthOfWidgetText: aText [
	^ self widthOfText: aText withFont: self widgetFont
]
