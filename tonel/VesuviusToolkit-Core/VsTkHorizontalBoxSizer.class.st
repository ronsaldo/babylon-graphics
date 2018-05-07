"
I am a  box sizer. I am Packing widgets in an horizontal line.
"
Class {
	#name : #VsTkHorizontalBoxSizer,
	#superclass : #VsTkBoxSizer,
	#category : #'VesuviusToolkit-Core-Sizer'
}

{ #category : #protected }
VsTkHorizontalBoxSizer >> boxDirectionOf: aPoint [
	^ aPoint x
]

{ #category : #protected }
VsTkHorizontalBoxSizer >> boxOppositeDirectionOf: aPoint [
	^ aPoint y
]

{ #category : #protected }
VsTkHorizontalBoxSizer >> composeDirection: direction withOpposite: opposite [
	^ direction @ opposite
]
