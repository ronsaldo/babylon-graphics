"
I represent a complex number. I am used for some geometrical computations that involve angles.

"
Class {
	#name : #BabylonComplex,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #accessing }
BabylonComplex class >> angle: angle [
	^ self x: angle cos y: angle sin
]

{ #category : #'instance creation' }
BabylonComplex class >> r: x [
	^ self new x: x; y: 0; yourself
]

{ #category : #'instance creation' }
BabylonComplex class >> r: x i: y [
	^ self new x: x; y: y; yourself
]

{ #category : #accessing }
BabylonComplex class >> radius: radius angle: angle [
	^ self x: radius * angle cos y: radius * angle sin
]

{ #category : #'instance creation' }
BabylonComplex class >> x: x y: y [
	^ self new x: x; y: y; yourself
]

{ #category : #arithmetic }
BabylonComplex >> * other [
	^ self class
		x: (x * other x) - (y * other y)
		y: (x * other y) + (y * other x)
]

{ #category : #arithmetic }
BabylonComplex >> + other [
	^ self class x: x + other x y: y + other y
]

{ #category : #arithmetic }
BabylonComplex >> - other [
	^ self class x: x - other x y: y - other y
]

{ #category : #arithmetic }
BabylonComplex >> / other [
	^ self * other reciprocal
]

{ #category : #comparing }
BabylonComplex >> = other [
	^ x = other x and: [ y = other y ]
]

{ #category : #converting }
BabylonComplex >> asBabylonComplex [
	^ self
]

{ #category : #converting }
BabylonComplex >> asPoint [
	^ x @ y
]

{ #category : #comparing }
BabylonComplex >> closeTo: other [
	^ (x closeTo: other x) and: [ y closeTo: other y ]
]

{ #category : #arithmetic }
BabylonComplex >> conjugated [
	^ self class x: x y: y negated
]

{ #category : #comparing }
BabylonComplex >> hash [
	^ self class hash bitXor:
		(x hash bitXor:
		(y hash))
]

{ #category : #accessing }
BabylonComplex >> i [
	^ y
]

{ #category : #accessing }
BabylonComplex >> i: aNumber [
	y := aNumber
]

{ #category : #arithmetic }
BabylonComplex >> length [
	^ ((x*x) + (y*y)) sqrt
]

{ #category : #arithmetic }
BabylonComplex >> length2 [
	^ (x*x) + (y*y)
]

{ #category : #arithmetic }
BabylonComplex >> negated [
	^ self class x: x negated y: y negated
]

{ #category : #accessing }
BabylonComplex >> r [
	^ x
]

{ #category : #accessing }
BabylonComplex >> r: aNumber [
	x := aNumber
]

{ #category : #arithmetic }
BabylonComplex >> reciprocal [
	| il |
	il := self length2 reciprocal.
	^ self class x: x * il y: y negated * il
]

{ #category : #accessing }
BabylonComplex >> x [
	^ x
]

{ #category : #accessing }
BabylonComplex >> x: anObject [
	x := anObject
]

{ #category : #accessing }
BabylonComplex >> y [
	^ y
]

{ #category : #accessing }
BabylonComplex >> y: anObject [
	y := anObject
]
