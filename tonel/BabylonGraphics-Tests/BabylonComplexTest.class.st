"
A PompeiiComplexTest is a test class for testing the behavior of PompeiiComplex
"
Class {
	#name : #BabylonComplexTest,
	#superclass : #TestCase,
	#category : #'BabylonGraphics-Tests'
}

{ #category : #tests }
BabylonComplexTest >> testAdd [
	| z1 z2 zr |
	z1 := BabylonComplex r: 1 i: 2.
	z2 := BabylonComplex r: 3 i: 4.
	zr := BabylonComplex r: 4 i: 6.
	self assert: z1 + z2 equals: zr
]

{ #category : #tests }
BabylonComplexTest >> testConjugated [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: z conjugated equals: (BabylonComplex r: 3 i: -4).
]

{ #category : #tests }
BabylonComplexTest >> testDivide [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: (z / z  closeTo: (BabylonComplex r: 1 i: 0)).
]

{ #category : #tests }
BabylonComplexTest >> testLength [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: z length equals: 5
]

{ #category : #tests }
BabylonComplexTest >> testLength2 [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: z length2 equals: 25
]

{ #category : #tests }
BabylonComplexTest >> testMultiply [
	| z1 z2 zr |
	z1 := BabylonComplex r: 1 i: 2.
	z2 := BabylonComplex r: 3 i: 0.
	zr := BabylonComplex r: 3 i: 6.
	self assert: z1 * z2 equals: zr
]

{ #category : #tests }
BabylonComplexTest >> testMultiply2 [
	| z1 z2 zr |
	z1 := BabylonComplex r: 1 i: 2.
	z2 := BabylonComplex r: 3 i: 1.
	zr := BabylonComplex r: 1 i: 7.
	self assert: z1 * z2 equals: zr
]

{ #category : #tests }
BabylonComplexTest >> testNegated [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: z negated equals: (BabylonComplex r: -3 i: -4).
]

{ #category : #tests }
BabylonComplexTest >> testReciprocal [
	| z |
	z := BabylonComplex r: 3 i: 4.
	self assert: (z * z reciprocal closeTo: (BabylonComplex r: 1 i: 0)).
]

{ #category : #tests }
BabylonComplexTest >> testSubtract [
	| z1 z2 zr |
	z1 := BabylonComplex r: 1 i: 2.
	z2 := BabylonComplex r: 3 i: 5.
	zr := BabylonComplex r: -2 i: -3.
	self assert: z1 - z2 equals: zr
]
