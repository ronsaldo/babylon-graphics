"
I am an element in a sizer.
"
Class {
	#name : #VsTkSizerElement,
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
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #initialization }
VsTkSizerElement class >> initialize [
	TopBorder := 1<<0.
	BottomBorder := 1<<1.
	LeftBorder := 1<<2.
	RightBorder := 1<<3.
	
	Expanded := 1<<4.
	Shaped := 1<<5.
	AllBorders := TopBorder | BottomBorder | LeftBorder | RightBorder.
]

{ #category : #applying }
VsTkSizerElement >> adjustExtent: newExtent position: position [
	| outerBounds |
	outerBounds := position + self borderPosition extent: newExtent - self borderExtent.
	^ outerBounds
]

{ #category : #accessing }
VsTkSizerElement >> allBorders [
	flags := flags | AllBorders
]

{ #category : #applying }
VsTkSizerElement >> applyIntoExtent: newExtent position: position [
	self subclassResponsibility
]

{ #category : #accessing }
VsTkSizerElement >> borderExtent [
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
VsTkSizerElement >> borderPosition [
	| x y |
	x := 0.
	y := 0.
	self hasLeftBorder ifTrue: [ x := borderSize ].
	self hasTopBorder ifTrue: [ y := borderSize ].
	
	^ x @ y
]

{ #category : #accessing }
VsTkSizerElement >> borderSize [
	^ borderSize
]

{ #category : #accessing }
VsTkSizerElement >> borderSize: anObject [
	borderSize := anObject
]

{ #category : #accessing }
VsTkSizerElement >> bottomBorder [
	flags := flags | BottomBorder
]

{ #category : #actions }
VsTkSizerElement >> expand [
	self isExpanded: true.
]

{ #category : #accessing }
VsTkSizerElement >> extent [
	self subclassResponsibility
]

{ #category : #accessing }
VsTkSizerElement >> flags [
	^ flags
]

{ #category : #accessing }
VsTkSizerElement >> flags: anObject [
	flags := anObject
]

{ #category : #accessing }
VsTkSizerElement >> hasBottomBorder [
	^ flags anyMask: BottomBorder
]

{ #category : #accessing }
VsTkSizerElement >> hasLeftBorder [
	^ flags anyMask: LeftBorder
]

{ #category : #accessing }
VsTkSizerElement >> hasRightBorder [
	^ flags anyMask: RightBorder
]

{ #category : #accessing }
VsTkSizerElement >> hasTopBorder [
	^ flags anyMask: TopBorder
]

{ #category : #initialization }
VsTkSizerElement >> initialize [
	super initialize.
	proportion := 0.
	flags := 0.
	borderSize := 0.
]

{ #category : #accessing }
VsTkSizerElement >> isExpanded [
	^ flags anyMask: Expanded
]

{ #category : #accessing }
VsTkSizerElement >> isExpanded: aBoolean [
	self setFlagBits: Expanded value: aBoolean
]

{ #category : #accessing }
VsTkSizerElement >> leftBorder [
	flags := flags | LeftBorder
]

{ #category : #accessing }
VsTkSizerElement >> minimalExtent [
	self subclassResponsibility
]

{ #category : #accessing }
VsTkSizerElement >> proportion [
	^ proportion
]

{ #category : #accessing }
VsTkSizerElement >> proportion: anObject [
	proportion := anObject
]

{ #category : #accessing }
VsTkSizerElement >> rightBorder [
	flags := flags | RightBorder
]

{ #category : #accessing }
VsTkSizerElement >> setFlagBits: bits value: aBoolean [
	aBoolean ifTrue: [
		flags := flags | bits
	] ifFalse: [
		flags := flags & (bits bitInvert).
	]
]

{ #category : #accessing }
VsTkSizerElement >> topBorder [
	flags := flags | TopBorder
]
