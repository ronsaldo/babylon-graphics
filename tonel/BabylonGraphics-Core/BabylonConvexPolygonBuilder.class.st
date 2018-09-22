"
I am used to build a convex polygon.
"
Class {
	#name : #BabylonConvexPolygonBuilder,
	#superclass : #BabylonShape,
	#instVars : [
		'vertices',
		'lastPosition',
		'arcSegmentLength',
		'maxArcSegments'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #defaults }
BabylonConvexPolygonBuilder class >> defaultArcSegmentLength [
	^ 3
]

{ #category : #defaults }
BabylonConvexPolygonBuilder class >> defaultMaxArcSegments [
	^ 16
]

{ #category : #adding }
BabylonConvexPolygonBuilder >> addVertex: aVertex [
	^ vertices add: (lastPosition := aVertex)
]

{ #category : #adding }
BabylonConvexPolygonBuilder >> arcTo: destination angle: angle cw: isClockWise [
	| sourceComplex destComplex rotation center  actualAngle radius arcLength destVector arcSegments |
	sourceComplex := lastPosition asBabylonComplex.
	destComplex := destination asBabylonComplex.
	isClockWise ifFalse: [ 
		actualAngle := angle negated.
	].
	rotation := BabylonComplex angle: actualAngle.
	
	center := (destComplex - (sourceComplex * rotation)) / (1 asBabylonComplex  - rotation).
	
	radius := (destComplex - center) length.
	(radius closeTo: 0.0) ifTrue: [ ^ self addVertex: destination ].
	
	arcLength := radius * actualAngle abs.
	destVector := sourceComplex - center.
	arcSegments := arcLength / arcSegmentLength min: maxArcSegments.
	arcSegments <= 0 ifTrue: [ ^ self addVertex: destination ].
	
	rotation := BabylonComplex angle: actualAngle / arcSegments.
	1 to: arcSegments + 1 do: [ :i |
		self addVertex: (center + destVector) asPoint.
		destVector := rotation * destVector.
	].

	self addVertex: destination.
]

{ #category : #initialization }
BabylonConvexPolygonBuilder >> initialize [
	super initialize.
	vertices := OrderedCollection new.
	arcSegmentLength := self class defaultArcSegmentLength.
	maxArcSegments := self class defaultMaxArcSegments.
	
]

{ #category : #drawing }
BabylonConvexPolygonBuilder >> polygon [
	^ BabylonConvexPolygon vertices: vertices asArray
]
