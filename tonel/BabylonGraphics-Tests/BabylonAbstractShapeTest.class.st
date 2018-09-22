"
A PompeiiAbstractShapeTest is a test class for testing the behavior of PompeiiAbstractShape
"
Class {
	#name : #BabylonAbstractShapeTest,
	#superclass : #TestCase,
	#category : #'BabylonGraphics-Tests'
}

{ #category : #tests }
BabylonAbstractShapeTest >> testRectangleShape [
	| shape rectangle |
	rectangle := 0 @ 0 extent: 128 @ 128.
	shape := rectangle asBabylonGenericShape.
	self assert: shape boundingBox = rectangle.
]

{ #category : #tests }
BabylonAbstractShapeTest >> testRoundedRectangleShape [
	| shape rectangle |
	rectangle := 0 @ 0 extent: 128 @ 128.
	shape := BabylonConvexPolygon rectangle: rectangle round: 15.
	self assert: shape boundingBox = rectangle.
]
