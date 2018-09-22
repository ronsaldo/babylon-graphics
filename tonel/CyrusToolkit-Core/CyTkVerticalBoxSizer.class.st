"
I am a  box sizer. I am Packing widgets in a vertical line.
"
Class {
	#name : #CyTkVerticalBoxSizer,
	#superclass : #CyTkBoxSizer,
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #protected }
CyTkVerticalBoxSizer >> boxDirectionOf: aPoint [
	^ aPoint y
]

{ #category : #protected }
CyTkVerticalBoxSizer >> boxOppositeDirectionOf: aPoint [
	^ aPoint x
]

{ #category : #protected }
CyTkVerticalBoxSizer >> composeDirection: direction withOpposite: opposite [
	^ opposite @ direction
]
