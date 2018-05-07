"
A PompeiiAbstractShapeTest is a test class for testing the behavior of PompeiiAbstractShape
"
Class {
	#name : #PompeiiAbstractShapeTest,
	#superclass : #TestCase,
	#category : #'PompeiiGraphics-Tests'
}

{ #category : #tests }
PompeiiAbstractShapeTest >> testRectangleShape [
	| shape rectangle |
	rectangle := 0 @ 0 extent: 128 @ 128.
	shape := rectangle asPompeiiGenericShape.
	self assert: shape boundingBox = rectangle.
]

{ #category : #tests }
PompeiiAbstractShapeTest >> testRoundedRectangleShape [
	| shape rectangle |
	rectangle := 0 @ 0 extent: 128 @ 128.
	shape := PompeiiConvexPolygon rectangle: rectangle round: 15.
	self assert: shape boundingBox = rectangle.
]
