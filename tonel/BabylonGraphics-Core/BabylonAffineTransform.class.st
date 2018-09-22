"
I represent an affine 2D transform.

I represent the following 3x3 matrix:

|  sx shx x |
| shy sy y |
|  0 0 1      |
"
Class {
	#name : #BabylonAffineTransform,
	#superclass : #BabylonTransform,
	#instVars : [
		'sx',
		'shx',
		'x',
		'shy',
		'sy',
		'y'
	],
	#category : #'BabylonGraphics-Core-Matrices'
}

{ #category : #comparing }
BabylonAffineTransform >> = other [
	^ self class = other class and:
	[ sx = other sx and: [ shx = other shx and: [ x = other x and:
	[ shy = other shy and: [ sy = other sy and: [ y = other y]]]]]]
]

{ #category : #converting }
BabylonAffineTransform >> asFloatMatrix3 [
	^ {
		sx asFloat . shx asFloat . x asFloat .
		shy asFloat . sy asFloat . y asFloat .
		0.0 . 0.0 . 1.0
	}
]

{ #category : #converting }
BabylonAffineTransform >> asFloatMatrix4 [
	^ {
		sx asFloat . shx asFloat . 0.0 . x asFloat .
		shy asFloat . sy asFloat . 0.0 . y asFloat .
		0.0 . 0.0 . 1.0 . 0.0 .
		0.0 . 0.0 . 0.0 . 1.0
	}
]

{ #category : #transformation }
BabylonAffineTransform >> clearTranslation [
	"reset a translation from matrix, leaving only scale and rotation"
	
	x := y := 0.0
]

{ #category : #comparing }
BabylonAffineTransform >> hash [
	^ self class hash bitXor:
	(sx hash bitXor: (shx hash bitXor: (x hash bitXor:
	(shy hash bitXor: (sy hash bitXor: (y hash))))))
]

{ #category : #initialization }
BabylonAffineTransform >> initialize [
	self loadIdentity
]

{ #category : #private }
BabylonAffineTransform >> inverseTransformHalfPi: aPoint [
	"assume sx,sy = 0
		
	px := y0*shx + x.
	py := x0*shy + y.
	
	we doing inverse one, trying to find x0,y0 for rest of given variables (px,py,x,y,sx,sy,shx,shy)"
	| px py y0 x0 |
	
	px := aPoint x.
	py := aPoint y.

	x0 := py - y  / shy.
	y0 := px - x  / shx.

	^ x0@y0
	
]

{ #category : #private }
BabylonAffineTransform >> inverseTransformPiOrZero: aPoint [
	"assume shx,shy = 0
		
	px := x0*sx + x.
	py := y0*sy + y.
	we doing inverse one, trying to find x0,y0 for rest of given variables (px,py,x,y,sx,sy,shx,shy)"
	
	| px py y0 x0 |
	
	px := aPoint x.
	py := aPoint y.

	x0 := px - x / sx.
	y0 := py - y / sy.

	^ x0@y0
	
]

{ #category : #accessing }
BabylonAffineTransform >> inverted [
	"answer an inverse transformation of receiver"
	| det |
	det := sx * sy - (shx * shy).
	^ self class new
		sx: sy / det;
		sy: sy / det;
		shx: shx * -1 / det;
		shy: shy * -1 / det;
		x: shx * y - (x * sy) / det;
		y: shy * x - (sx * y) / det;
		yourself
]

{ #category : #transformation }
BabylonAffineTransform >> loadAffineTransform: m [

	x := m x.
	y := m y.
	sx := m sx.
	sy := m sy.
	shx := m shx.
	shy := m shy.
]

{ #category : #transformation }
BabylonAffineTransform >> loadIdentity [
	"initialize with identity transform"
	sx := sy := 1.0.
	shx := shy := x := y := 0.0.
	
	
]

{ #category : #transformation }
BabylonAffineTransform >> multiplyBy: m [

	"multiply receiver by given affine matrix"
"
| sx   shx   x   |        | sx'   shx'   x'   | 
| shy sy     y    |   *    | shy' sy'     y'   |
|  0     0     1   |        | 0  	0   		1	|       

"	
	
	| nsx nshx nx nshy nsy ny |
	
	nsx := sx * m sx + (shx  * m shy).
	nshx := sx * m shx + (shx * m sy).
	nx := sx * m x + (shx * m y) + x.
	
	nshy := shy * m sx + (sy * m shy).
	nsy := shy * m shx  + (sy * m sy).
	ny := shy* m x + (sy * m y) + y.
	
	sx := nsx.
	sy := nsy.
	shx := nshx.
	shy := nshy.
	x := nx.
	y := ny.		
]

{ #category : #transformation }
BabylonAffineTransform >> restoreAfter: aBlock [
	|previous|
	previous := self copy.
	aBlock ensure: [ self loadAffineTransform: previous ]
]

{ #category : #transformation }
BabylonAffineTransform >> rotateByDegrees: angle [


	^ self rotateByRadians: angle degreesToRadians
]

{ #category : #transformation }
BabylonAffineTransform >> rotateByRadians: angle [

	"multiply receiver by rotation matrix

| sx   shx   x   |        | cos -sin 0  |             | (sx*cos)+(shx*sin)   (-sx*sin+shx*cos)  x |
| shy sy     y   |   *   | sin   cos 0 |   ===> | (shy*cos)+(sy*sin)   (-shy*sin)+sy*cos) y |
|  0     0     1   |       | 0     0   1   |             |        0                                 0                1  |

"
	| cos sin newSx newSy |
	
	cos := angle cos.
	sin := angle sin.
	
	
	newSx := sx*cos + (shx*sin).
	newSy := sy*cos - (shy*sin).
	
	shx := shx*cos - (sx*sin).
	shy := shy*cos + (sy*sin).

	sx := newSx.
	sy := newSy.
]

{ #category : #accessing }
BabylonAffineTransform >> scale [
	^ sx@sy
]

{ #category : #transformation }
BabylonAffineTransform >> scaleBy: factor [

	"multiply receiver by uniform scale matrix

| sx   shx   x   |       | (f x) 0 0  |             | sx*(f x)    shx*(f y)  x |
| shy sy     y   |   *   | 0 (f y) 0  |    ===> | shy*(f x)     sy*(f y)    y |
|  0     0     1  |        | 0 0     1  |                |  0      0              1  |

"	
	factor isPoint ifTrue: [
		sx := sx*factor x.
		shx := shx*factor y.
		sy := sy*factor y.
		shy := shy*factor x. 		
	] ifFalse: [
		sx := sx*factor.
		shx := shx*factor.
		sy := sy*factor.
		shy := shy*factor. ]

]

{ #category : #transformation }
BabylonAffineTransform >> scaleX: fx Y: fy [

	"multiply receiver by scale matrix

| sx   shx   x   |        | fx 0 0  |              | sx*fx    shx*fx  x |
| shy sy     y   |   *   | 0 fy 0  |    ===> | shy*fy  sy*fy   y |
|  0     0     1   |       | 0 0  1  |              |  0          0        1  |

"
	sx := sx*fx.
	shx := shx*fx.
	sy := sy*fy.
	shy := shy*fy.

]

{ #category : #accessing }
BabylonAffineTransform >> shx [
	^ shx
]

{ #category : #accessing }
BabylonAffineTransform >> shx: anObject [
	shx := anObject
]

{ #category : #accessing }
BabylonAffineTransform >> shy [
	^ shy
]

{ #category : #accessing }
BabylonAffineTransform >> shy: anObject [
	shy := anObject
]

{ #category : #accessing }
BabylonAffineTransform >> sx [
	^ sx
]

{ #category : #accessing }
BabylonAffineTransform >> sx: anObject [
	sx := anObject
]

{ #category : #accessing }
BabylonAffineTransform >> sy [
	^ sy
]

{ #category : #accessing }
BabylonAffineTransform >> sy: anObject [
	sy := anObject
]

{ #category : #'vector-transform' }
BabylonAffineTransform >> transform: aPoint [
	| px py |
	px := aPoint x.
	py := aPoint y.
	^ ((sx * px) + (shx*py) + x) @ ((shy * px) + (sy*py) + y)
]

{ #category : #transformation }
BabylonAffineTransform >> translateBy: aPoint [

	^ self translateX: aPoint x Y: aPoint y
]

{ #category : #transformation }
BabylonAffineTransform >> translateX: px Y: py [


" multiply receiver by translation matrix :

| sx   shx   x   |        | 1  0  px |             |	sx  shx  (sx*px + shx*py + x) |
| shy sy     y   |   *   | 0  1  py |   ===> | shy  sy  (shy*px + sy*py + y)  |
|  0     0     1   |       | 0  0   1  |             |  0     0    1  |

"
	x := (sx*px) + (shx*py) + x.
	y := (shy*px) + (sy*py) + y.

]

{ #category : #transformation }
BabylonAffineTransform >> translateX: px y: py [

" multiply receiver by translation matrix :

| sx   shx   x   |        | 1  0  px |             |	sx  shx  (sx*px + shx*py + x) |
| shy sy     y   |   *   | 0  1  py |   ===> | shy  sy  (shy*px + sy*py + y)  |
|  0     0     1   |       | 0  0   1  |             |  0     0    1  |

"
	x := (sx*px) + (shx*py) + x.
	y := (shy*px) + (sy*py) + y.

]

{ #category : #accessing }
BabylonAffineTransform >> translation [
	^ x@y
]

{ #category : #accessing }
BabylonAffineTransform >> translation: aPoint [
	x := aPoint x.
	y := aPoint y.
]

{ #category : #transformation }
BabylonAffineTransform >> transposed [
	
	| s |
	s := shx.
	shx := shy.
	shy := s.
]

{ #category : #accessing }
BabylonAffineTransform >> x [
	^ x
]

{ #category : #accessing }
BabylonAffineTransform >> x: anObject [
	x := anObject
]

{ #category : #accessing }
BabylonAffineTransform >> y [
	^ y
]

{ #category : #accessing }
BabylonAffineTransform >> y: anObject [
	y := anObject
]
