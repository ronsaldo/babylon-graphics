"
I represent a generic 3x3 matrix. I am usually used for making some projective 2D transforms.

I represent the following 3x3 matrix:

|  sx shx x |
| shy sy y |
|  w0 w1 w2  |
"
Class {
	#name : #PompeiiGenericTransform,
	#superclass : #PompeiiAffineTransform,
	#instVars : [
		'w0',
		'w1',
		'w2'
	],
	#category : #'PompeiiGraphics-Core-Matrices'
}

{ #category : #comparing }
PompeiiGenericTransform >> = other [
	^ super = other and:
	[ w0 = other w0 and: [ w1 = other w1 and: [ w2 = other w2 ]]]
]

{ #category : #converting }
PompeiiGenericTransform >> asFloatMatrix3 [
	^ {
		sx asFloat . shx asFloat . x asFloat .
		shy asFloat . sy asFloat . y asFloat .
		w0 . w1 . w2
	}
]

{ #category : #converting }
PompeiiGenericTransform >> asFloatMatrix4 [
	^ {
		sx asFloat . shx asFloat . 0.0 . x asFloat .
		shy asFloat . sy asFloat . 0.0 . y asFloat .
		0.0 . 0.0 . 1.0 . 0.0 .
		w0 . w1 . 0.0 . w2
	}
]

{ #category : #comparing }
PompeiiGenericTransform >> hash [
	^ super hash bitXor: (w0 hash bitXor: (w1 hash bitXor: w2))
]

{ #category : #transformations }
PompeiiGenericTransform >> loadIdentity [
	"initialize with identity transform"
	super loadIdentity.
	w0 := w1 := 0.0.
	w2 := 1.0
]

{ #category : #'vector-transform' }
PompeiiGenericTransform >> transform: aPoint [
	| px py w |
	px := aPoint x.
	py := aPoint y.
	w := (w0 * px) + (w1 * py) + w2.
	^ (((sx * px) + (shx*py) + x) / w) @ (((shy * px) + (sy*py) + y) / w)
]

{ #category : #accessing }
PompeiiGenericTransform >> w0 [
	^ w0
]

{ #category : #accessing }
PompeiiGenericTransform >> w0: anObject [
	w0 := anObject
]

{ #category : #accessing }
PompeiiGenericTransform >> w1 [
	^ w1
]

{ #category : #accessing }
PompeiiGenericTransform >> w1: anObject [
	^ w1 := anObject
]

{ #category : #accessing }
PompeiiGenericTransform >> w2 [
	^ w2
]

{ #category : #accessing }
PompeiiGenericTransform >> w2: anObject [
	w2 := anObject
]
