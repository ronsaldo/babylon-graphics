Class {
	#name : #BabylonMutablePoint,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #'instance creation' }
BabylonMutablePoint >> fromFixedPointForBabylonRendering [
	^ x fromFixedPointForBabylonRendering @ y fromFixedPointForBabylonRendering
]

{ #category : #accessing }
BabylonMutablePoint >> x [
	^ x
]

{ #category : #accessing }
BabylonMutablePoint >> x: anObject [
	x := anObject
]

{ #category : #accessing }
BabylonMutablePoint >> y [
	^ y
]

{ #category : #accessing }
BabylonMutablePoint >> y: anObject [
	y := anObject
]
