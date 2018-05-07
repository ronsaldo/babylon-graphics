"
A PompeiiComplexTest is a test class for testing the behavior of PompeiiComplex
"
Class {
	#name : #PompeiiComplexTest,
	#superclass : #TestCase,
	#category : #'PompeiiGraphics-Tests'
}

{ #category : #tests }
PompeiiComplexTest >> testAdd [
	| z1 z2 zr |
	z1 := PompeiiComplex r: 1 i: 2.
	z2 := PompeiiComplex r: 3 i: 4.
	zr := PompeiiComplex r: 4 i: 6.
	self assert: z1 + z2 equals: zr
]

{ #category : #tests }
PompeiiComplexTest >> testConjugated [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: z conjugated equals: (PompeiiComplex r: 3 i: -4).
]

{ #category : #tests }
PompeiiComplexTest >> testDivide [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: (z / z  closeTo: (PompeiiComplex r: 1 i: 0)).
]

{ #category : #tests }
PompeiiComplexTest >> testLength [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: z length equals: 5
]

{ #category : #tests }
PompeiiComplexTest >> testLength2 [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: z length2 equals: 25
]

{ #category : #tests }
PompeiiComplexTest >> testMultiply [
	| z1 z2 zr |
	z1 := PompeiiComplex r: 1 i: 2.
	z2 := PompeiiComplex r: 3 i: 0.
	zr := PompeiiComplex r: 3 i: 6.
	self assert: z1 * z2 equals: zr
]

{ #category : #tests }
PompeiiComplexTest >> testMultiply2 [
	| z1 z2 zr |
	z1 := PompeiiComplex r: 1 i: 2.
	z2 := PompeiiComplex r: 3 i: 1.
	zr := PompeiiComplex r: 1 i: 7.
	self assert: z1 * z2 equals: zr
]

{ #category : #tests }
PompeiiComplexTest >> testNegated [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: z negated equals: (PompeiiComplex r: -3 i: -4).
]

{ #category : #tests }
PompeiiComplexTest >> testReciprocal [
	| z |
	z := PompeiiComplex r: 3 i: 4.
	self assert: (z * z reciprocal closeTo: (PompeiiComplex r: 1 i: 0)).
]

{ #category : #tests }
PompeiiComplexTest >> testSubtract [
	| z1 z2 zr |
	z1 := PompeiiComplex r: 1 i: 2.
	z2 := PompeiiComplex r: 3 i: 5.
	zr := PompeiiComplex r: -2 i: -3.
	self assert: z1 - z2 equals: zr
]
