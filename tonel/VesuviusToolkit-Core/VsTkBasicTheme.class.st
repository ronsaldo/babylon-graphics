"
I represent a basic theme in the vesubius toolkit.
"
Class {
	#name : #VsTkBasicTheme,
	#superclass : #VsTkTheme,
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
	#category : #'VesuviusToolkit-Core-Theme'
}

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildButton: button meshOn: meshBuilder [
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
VsTkBasicTheme >> buildLabel: label meshOn: meshBuilder [
	meshBuilder text
		color: labelColor;
		font: self widgetFont;
		draw: label text onRectangleCenterLeft: label localBounds
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildMenu: menu meshOn: meshBuilder [
	meshBuilder fill
		color: menuBackgroundColor;
		rectangle: menu localBounds
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildMenuBar: menuBar meshOn: meshBuilder [
	meshBuilder fill
		color: menuBarBackgroundColor;
		rectangle: menuBar localBounds
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildMenuItem: menuItem meshOn: meshBuilder [
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
VsTkBasicTheme >> buildMenuSeparator: menuSeparator meshOn: meshBuilder [
	| bounds |
	bounds := menuSeparator localBounds.
	meshBuilder stroke
		color: menuSeparatorColor;
		drawLine: { bounds leftCenter . bounds rightCenter }

]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildStatusBar: statusBar meshOn: meshBuilder [
	meshBuilder fill
		color: statusBarBackgroundColor;
		rectangle: statusBar localBounds
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> buildToolBar: toolBar meshOn: meshBuilder [
	meshBuilder fill
		color: toolBarBackgroundColor;
		rectangle: toolBar localBounds
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeButtonMinimalExtent: button [
	^ buttonLabelBorderExtent + (self extentOfWidgetText: button label)
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeLabelMinimalExtent: label [
	^ self extentOfWidgetText: label text
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeMenuBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeMenuItemMinimalExtent: menuItem [
	^ menuItemLabelBorderExtent + (self extentOfWidgetText: menuItem label)
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeMenuSeparatorMinimalExtent: menuItem [
	^ 3@3
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeStatusBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeToolBarMinimalExtent: button [
	^ self extentOfWidgetText: ' '
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> extentOfWidgetText: aText [
	^ self extentOfText: aText withFont: self widgetFont
]

{ #category : #initialization }
VsTkBasicTheme >> initialize [
	super initialize.
	self setParameters.
]

{ #category : #initialization }
VsTkBasicTheme >> setParameters [
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
VsTkBasicTheme >> widgetFont [
	^ widgetFont ifNil: [ widgetFont := LogicalFont familyName: 'Arial' pointSize: 20 ]
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> widthOfWidgetText: aText [
	^ self widthOfText: aText withFont: self widgetFont
]
