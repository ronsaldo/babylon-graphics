"
I am an element in a sizer.
"
Class {
	#name : #CyTkSizerElement,
	#superclass : #Object,
	#instVars : [
		'proportion',
		'flags',
		'borderSize'
	],
	#classVars : [
		'AllBorders',
		'BottomBorder',
		'Expanded',
		'LeftBorder',
		'RightBorder',
		'Shaped',
		'TopBorder'
	],
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #initialization }
CyTkSizerElement class >> initialize [
	TopBorder := 1<<0.
	BottomBorder := 1<<1.
	LeftBorder := 1<<2.
	RightBorder := 1<<3.
	
	Expanded := 1<<4.
	Shaped := 1<<5.
	AllBorders := TopBorder | BottomBorder | LeftBorder | RightBorder.
]

{ #category : #applying }
CyTkSizerElement >> adjustExtent: newExtent position: position [
	| outerBounds |
	outerBounds := position + self borderPosition extent: newExtent - self borderExtent.
	^ outerBounds
]

{ #category : #accessing }
CyTkSizerElement >> allBorders [
	flags := flags | AllBorders
]

{ #category : #applying }
CyTkSizerElement >> applyIntoExtent: newExtent position: position [
	self subclassResponsibility
]

{ #category : #accessing }
CyTkSizerElement >> borderExtent [
	| borderWidth borderHeight |
	borderWidth := 0.
	borderHeight := 0.
	self hasLeftBorder ifTrue: [ borderWidth := borderWidth + borderSize ].
	self hasRightBorder ifTrue: [ borderWidth := borderWidth + borderSize ].
	self hasTopBorder ifTrue: [ borderHeight := borderHeight + borderSize ].
	self hasBottomBorder ifTrue: [ borderHeight := borderHeight + borderSize ].
	^ borderWidth @ borderHeight
]

{ #category : #accessing }
CyTkSizerElement >> borderPosition [
	| x y |
	x := 0.
	y := 0.
	self hasLeftBorder ifTrue: [ x := borderSize ].
	self hasTopBorder ifTrue: [ y := borderSize ].
	
	^ x @ y
]

{ #category : #accessing }
CyTkSizerElement >> borderSize [
	^ borderSize
]

{ #category : #accessing }
CyTkSizerElement >> borderSize: anObject [
	borderSize := anObject
]

{ #category : #accessing }
CyTkSizerElement >> bottomBorder [
	flags := flags | BottomBorder
]

{ #category : #actions }
CyTkSizerElement >> expand [
	self isExpanded: true.
]

{ #category : #accessing }
CyTkSizerElement >> extent [
	self subclassResponsibility
]

{ #category : #accessing }
CyTkSizerElement >> flags [
	^ flags
]

{ #category : #accessing }
CyTkSizerElement >> flags: anObject [
	flags := anObject
]

{ #category : #accessing }
CyTkSizerElement >> hasBottomBorder [
	^ flags anyMask: BottomBorder
]

{ #category : #accessing }
CyTkSizerElement >> hasLeftBorder [
	^ flags anyMask: LeftBorder
]

{ #category : #accessing }
CyTkSizerElement >> hasRightBorder [
	^ flags anyMask: RightBorder
]

{ #category : #accessing }
CyTkSizerElement >> hasTopBorder [
	^ flags anyMask: TopBorder
]

{ #category : #initialization }
CyTkSizerElement >> initialize [
	super initialize.
	proportion := 0.
	flags := 0.
	borderSize := 0.
]

{ #category : #accessing }
CyTkSizerElement >> isExpanded [
	^ flags anyMask: Expanded
]

{ #category : #accessing }
CyTkSizerElement >> isExpanded: aBoolean [
	self setFlagBits: Expanded value: aBoolean
]

{ #category : #accessing }
CyTkSizerElement >> leftBorder [
	flags := flags | LeftBorder
]

{ #category : #accessing }
CyTkSizerElement >> minimalExtent [
	self subclassResponsibility
]

{ #category : #accessing }
CyTkSizerElement >> proportion [
	^ proportion
]

{ #category : #accessing }
CyTkSizerElement >> proportion: anObject [
	proportion := anObject
]

{ #category : #accessing }
CyTkSizerElement >> rightBorder [
	flags := flags | RightBorder
]

{ #category : #accessing }
CyTkSizerElement >> setFlagBits: bits value: aBoolean [
	aBoolean ifTrue: [
		flags := flags | bits
	] ifFalse: [
		flags := flags & (bits bitInvert).
	]
]

{ #category : #accessing }
CyTkSizerElement >> topBorder [
	flags := flags | TopBorder
]
