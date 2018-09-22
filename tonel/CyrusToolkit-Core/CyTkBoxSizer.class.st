"
I am a box sizer.  I am packing widgets in a line.
"
Class {
	#name : #CyTkBoxSizer,
	#superclass : #CyTkSizer,
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #applying }
CyTkBoxSizer >> applyIntoExtent: newExtent position: position [
	| size requiredSize totalProportion elementSizes proportion remainingSize oppositeSize currentPosition elementSize oppositePosition |
	requiredSize := 0.
	totalProportion := 0.
	elementSizes := elements collect: #extent.
	elements doWithIndex: [ :element :index |
		proportion := element proportion.
		proportion = 0 ifTrue: [
			requiredSize := requiredSize + (self boxDirectionOf: (elementSizes at: index)).
		] ifFalse: [
			totalProportion := totalProportion + element proportion.
		]
	].

	size := self boxDirectionOf: newExtent.
	oppositeSize := self boxOppositeDirectionOf: newExtent.
	remainingSize := size - requiredSize max: 0.
	
	oppositePosition := self boxOppositeDirectionOf: position.
	currentPosition := self boxDirectionOf: position.
	elements doWithIndex: [ :element :index |
		proportion := element proportion.
		proportion = 0 ifTrue: [
			element isExpanded ifTrue: [ 
				elementSize := self composeDirection: (self boxDirectionOf: (elementSizes at: index)) withOpposite: oppositeSize.
			] ifFalse: [ 
				elementSize := elementSizes at: index.
			].
		] ifFalse: [
			elementSize := self composeDirection: remainingSize * proportion // totalProportion withOpposite: oppositeSize.
		].
	
		element applyIntoExtent: elementSize position: (self composeDirection: currentPosition withOpposite: oppositePosition).
		currentPosition := currentPosition + (self boxDirectionOf: elementSize).
	].
	
]

{ #category : #protected }
CyTkBoxSizer >> boxDirectionOf: aPoint [
	self subclassResponsibility
]

{ #category : #protected }
CyTkBoxSizer >> boxOppositeDirectionOf: aPoint [
	self subclassResponsibility
]

{ #category : #protected }
CyTkBoxSizer >> composeDirection: direction withOpposite: opposite [
	self subclassResponsibility
]

{ #category : #applying }
CyTkBoxSizer >> extent [
	| size oppositeSize elementMinimalExtent |
	size := 0.
	oppositeSize := 0.

	elements do: [ :element |
		elementMinimalExtent := element extent.
		oppositeSize := oppositeSize max: (self boxOppositeDirectionOf: elementMinimalExtent).
		element proportion = 0 ifTrue: [
			size := size + (self boxDirectionOf: elementMinimalExtent)
		] ifFalse: [
			size := size + ((self boxDirectionOf: elementMinimalExtent)*element proportion)
		]
	].

	^ self composeDirection: size withOpposite: oppositeSize
	
]

{ #category : #applying }
CyTkBoxSizer >> minimalExtent [
	| size oppositeSize elementMinimalExtent |
	size := 0.
	oppositeSize := 0.

	elements do: [ :element |
		elementMinimalExtent := element minimalExtent.
		oppositeSize := oppositeSize max: (self boxOppositeDirectionOf: elementMinimalExtent).
		element proportion = 0 ifTrue: [
			size := size + (self boxDirectionOf: elementMinimalExtent)
		] ifFalse: [
			size := size + ((self boxDirectionOf: elementMinimalExtent)*element proportion)
		]
	].

	^ self composeDirection: size withOpposite: oppositeSize
	
]
