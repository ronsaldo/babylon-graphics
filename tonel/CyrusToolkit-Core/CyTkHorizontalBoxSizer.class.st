"
I am a  box sizer. I am Packing widgets in an horizontal line.
"
Class {
	#name : #CyTkHorizontalBoxSizer,
	#superclass : #CyTkBoxSizer,
	#category : #'CyrusToolkit-Core-Sizer'
}

{ #category : #protected }
CyTkHorizontalBoxSizer >> boxDirectionOf: aPoint [
	^ aPoint x
]

{ #category : #protected }
CyTkHorizontalBoxSizer >> boxOppositeDirectionOf: aPoint [
	^ aPoint y
]

{ #category : #protected }
CyTkHorizontalBoxSizer >> composeDirection: direction withOpposite: opposite [
	^ direction @ opposite
]
