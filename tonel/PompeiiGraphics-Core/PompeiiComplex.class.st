"
I represent a complex number. I am used for some geometrical computations that involve angles.

"
Class {
	#name : #PompeiiComplex,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'PompeiiGraphics-Core'
}

{ #category : #accessing }
PompeiiComplex class >> angle: angle [
	^ self x: angle cos y: angle sin
]

{ #category : #'instance creation' }
PompeiiComplex class >> r: x [
	^ self new x: x; y: 0; yourself
]

{ #category : #'instance creation' }
PompeiiComplex class >> r: x i: y [
	^ self new x: x; y: y; yourself
]

{ #category : #accessing }
PompeiiComplex class >> radius: radius angle: angle [
	^ self x: radius * angle cos y: radius * angle sin
]

{ #category : #'instance creation' }
PompeiiComplex class >> x: x y: y [
	^ self new x: x; y: y; yourself
]

{ #category : #arithmetic }
PompeiiComplex >> * other [
	^ self class
		x: (x * other x) - (y * other y)
		y: (x * other y) + (y * other x)
]

{ #category : #arithmetic }
PompeiiComplex >> + other [
	^ self class x: x + other x y: y + other y
]

{ #category : #arithmetic }
PompeiiComplex >> - other [
	^ self class x: x - other x y: y - other y
]

{ #category : #arithmetic }
PompeiiComplex >> / other [
	^ self * other reciprocal
]

{ #category : #comparing }
PompeiiComplex >> = other [
	^ x = other x and: [ y = other y ]
]

{ #category : #converting }
PompeiiComplex >> asPoint [
	^ x @ y
]

{ #category : #converting }
PompeiiComplex >> asPompeiiComplex [
	^ self
]

{ #category : #comparing }
PompeiiComplex >> closeTo: other [
	^ (x closeTo: other x) and: [ y closeTo: other y ]
]

{ #category : #arithmetic }
PompeiiComplex >> conjugated [
	^ self class x: x y: y negated
]

{ #category : #comparing }
PompeiiComplex >> hash [
	^ self class hash bitXor:
		(x hash bitXor:
		(y hash))
]

{ #category : #accessing }
PompeiiComplex >> i [
	^ y
]

{ #category : #accessing }
PompeiiComplex >> i: aNumber [
	y := aNumber
]

{ #category : #arithmetic }
PompeiiComplex >> length [
	^ ((x*x) + (y*y)) sqrt
]

{ #category : #arithmetic }
PompeiiComplex >> length2 [
	^ (x*x) + (y*y)
]

{ #category : #arithmetic }
PompeiiComplex >> negated [
	^ self class x: x negated y: y negated
]

{ #category : #accessing }
PompeiiComplex >> r [
	^ x
]

{ #category : #accessing }
PompeiiComplex >> r: aNumber [
	x := aNumber
]

{ #category : #arithmetic }
PompeiiComplex >> reciprocal [
	| il |
	il := self length2 reciprocal.
	^ self class x: x * il y: y negated * il
]

{ #category : #accessing }
PompeiiComplex >> x [
	^ x
]

{ #category : #accessing }
PompeiiComplex >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PompeiiComplex >> y [
	^ y
]

{ #category : #accessing }
PompeiiComplex >> y: anObject [
	y := anObject
]
