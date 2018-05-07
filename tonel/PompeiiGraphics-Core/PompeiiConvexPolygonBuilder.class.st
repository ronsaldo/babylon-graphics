"
I am used to build a convex polygon.
"
Class {
	#name : #PompeiiConvexPolygonBuilder,
	#superclass : #PompeiiShape,
	#instVars : [
		'vertices',
		'lastPosition',
		'arcSegmentLength',
		'maxArcSegments'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #defaults }
PompeiiConvexPolygonBuilder class >> defaultArcSegmentLength [
	^ 3
]

{ #category : #defaults }
PompeiiConvexPolygonBuilder class >> defaultMaxArcSegments [
	^ 16
]

{ #category : #adding }
PompeiiConvexPolygonBuilder >> addVertex: aVertex [
	^ vertices add: (lastPosition := aVertex)
]

{ #category : #adding }
PompeiiConvexPolygonBuilder >> arcTo: destination angle: angle cw: isClockWise [
	| sourceComplex destComplex rotation center  actualAngle radius arcLength destVector arcSegments |
	sourceComplex := lastPosition asPompeiiComplex.
	destComplex := destination asPompeiiComplex.
	isClockWise ifFalse: [ 
		actualAngle := angle negated.
	].
	rotation := PompeiiComplex angle: actualAngle.
	
	center := (destComplex - (sourceComplex * rotation)) / (1 asPompeiiComplex  - rotation).
	
	radius := (destComplex - center) length.
	(radius closeTo: 0.0) ifTrue: [ ^ self addVertex: destination ].
	
	arcLength := radius * actualAngle abs.
	destVector := sourceComplex - center.
	arcSegments := arcLength / arcSegmentLength min: maxArcSegments.
	arcSegments <= 0 ifTrue: [ ^ self addVertex: destination ].
	
	rotation := PompeiiComplex angle: actualAngle / arcSegments.
	1 to: arcSegments + 1 do: [ :i |
		self addVertex: (center + destVector) asPoint.
		destVector := rotation * destVector.
	].

	self addVertex: destination.
]

{ #category : #initialization }
PompeiiConvexPolygonBuilder >> initialize [
	super initialize.
	vertices := OrderedCollection new.
	arcSegmentLength := self class defaultArcSegmentLength.
	maxArcSegments := self class defaultMaxArcSegments.
	
]

{ #category : #drawing }
PompeiiConvexPolygonBuilder >> polygon [
	^ PompeiiConvexPolygon vertices: vertices asArray
]
