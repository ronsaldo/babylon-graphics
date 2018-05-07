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
		'buttonLabelColor'
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
VsTkBasicTheme >> computeButtonMinimalExtent: button [
	^ buttonLabelBorderExtent + (self extentOfWidgetText: button label)
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> computeLabelMinimalExtent: label [
	^ self extentOfWidgetText: label text
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
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> widgetFont [
	^ widgetFont ifNil: [ widgetFont := LogicalFont familyName: 'Arial' pointSize: 20 ]
]

{ #category : #'mesh widgets' }
VsTkBasicTheme >> widthOfWidgetText: aText [
	^ self widthOfText: aText withFont: self widgetFont
]
