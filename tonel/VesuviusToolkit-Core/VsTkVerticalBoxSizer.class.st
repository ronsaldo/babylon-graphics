"
I am a  box sizer. I am Packing widgets in a vertical line.
"
Class {
	#name : #VsTkVerticalBoxSizer,
	#superclass : #VsTkBoxSizer,
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #protected }
VsTkVerticalBoxSizer >> boxDirectionOf: aPoint [
	^ aPoint y
]

{ #category : #protected }
VsTkVerticalBoxSizer >> boxOppositeDirectionOf: aPoint [
	^ aPoint x
]

{ #category : #protected }
VsTkVerticalBoxSizer >> composeDirection: direction withOpposite: opposite [
	^ opposite @ direction
]
