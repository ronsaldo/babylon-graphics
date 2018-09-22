"
I represent a closed convex polygon.
"
Class {
	#name : #BabylonConvexPolygon,
	#superclass : #BabylonShape,
	#instVars : [
		'vertices'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #construction }
BabylonConvexPolygon class >> build: aBlock [
	| builder |
	builder := BabylonConvexPolygonBuilder new.
	aBlock value: builder.
	^ builder polygon
]

{ #category : #construction }
BabylonConvexPolygon class >> convexHull: aCollectionOfPoints [
	^ self vertices: (BabylonConvexHull points: aCollectionOfPoints)

]

{ #category : #construction }
BabylonConvexPolygon class >> radius: radius center: center sides: sides [
	^ self radius: radius center: center sides: sides phase: 0
]

{ #category : #construction }
BabylonConvexPolygon class >> radius: radius center: center sides: sides phase: anglePhase [
	| angle x y |
	^ self vertices: ((1 to: sides) collect: [ :i |
		angle := (i - 1) / sides * Float twoPi + anglePhase.
		x := radius * (angle cos).
		y := radius * (angle sin).
		(x + center x) @ (y + center y)
	])
]

{ #category : #construction }
BabylonConvexPolygon class >> radius: radius sides: sides [
	^ self radius: radius center: 0@0 sides: sides phase: 0
]

{ #category : #construction }
BabylonConvexPolygon class >> rectangle: aRectangle [
	^ self vertices: {
		aRectangle topLeft . aRectangle topRight .
		aRectangle bottomRight . aRectangle bottomLeft
	}

]

{ #category : #construction }
BabylonConvexPolygon class >> rectangle: aRectangle round: radius [
	| arcAngle |
	arcAngle := 90 degreesToRadians.
	
	^ self build: [ :builder |
		  builder
		
			"Lower left"
			addVertex: aRectangle bottomLeft + (0 @ radius negated);
			arcTo: aRectangle bottomLeft + (radius @ 0) angle: arcAngle cw: false;
			
			"Lower right"
			addVertex: aRectangle bottomRight + (radius negated @ 0);
			arcTo: aRectangle bottomRight + (0 @ radius negated) angle: arcAngle cw: false;

			"Upper right"
			addVertex: aRectangle topRight + (0 @ radius);
			arcTo: aRectangle topRight + (radius negated @ 0) angle: arcAngle cw: false;
			
			"Upper left"
			addVertex: aRectangle topLeft + (radius @ 0);
			arcTo: aRectangle topLeft + (0 @ radius) angle: arcAngle cw: false.
			
			"Finished"
	]

]

{ #category : #construction }
BabylonConvexPolygon class >> vertices: anArrayOfVertices [
	^ self new vertices: anArrayOfVertices
]

{ #category : #arithmetic }
BabylonConvexPolygon >> + otherPolygon [
	"Minkowski sum"
	| result destIndex |
	result := Array new: vertices size * otherPolygon vertices size.
	destIndex := 1.
	vertices do: [ :a |
		otherPolygon vertices do: [ :b |
			result at: destIndex put: a + b.
			destIndex := destIndex + 1
		]
	].

	^ self class convexHull: result
]

{ #category : #arithmetic }
BabylonConvexPolygon >> - otherPolygon [
	"Minkowski difference"
	| result destIndex |
	result := Array new: vertices size * otherPolygon vertices size.
	destIndex := 1.
	vertices do: [ :a |
		otherPolygon vertices do: [ :b |
			result at: destIndex put: a - b.
			destIndex := destIndex + 1
		]
	].

	^ self class convexHull: result
]

{ #category : #converting }
BabylonConvexPolygon >> asBabylonShapeFor: aPompeiiDriver [
	^ aPompeiiDriver convertPolygon: self
]

{ #category : #converting }
BabylonConvexPolygon >> asWavefrontOBJ [
	^ ByteString streamContents: [ :out |
		self saveWavefrontOBJInto: out
	]
]

{ #category : #accessing }
BabylonConvexPolygon >> boundingBox [
	^ Rectangle encompassing: vertices
]

{ #category : #'as yet unclassified' }
BabylonConvexPolygon >> drawWithBuilder: aBuilder [
	^ aBuilder drawConvexPolygon: self
]

{ #category : #converting }
BabylonConvexPolygon >> saveWavefrontOBJ: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate.
		self saveWavefrontOBJInto: out
	]
]

{ #category : #converting }
BabylonConvexPolygon >> saveWavefrontOBJInto: out [
	vertices do: [ :vertex |
		out nextPutAll: 'v '; print: vertex x; space; print: vertex y; nextPutAll: ' 0'; lf
	].

	1 to: vertices size do: [ :i |
		out nextPutAll: 'f '; print: i; space; print: (i % vertices size) + 1; lf
	]	

]

{ #category : #accessing }
BabylonConvexPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
BabylonConvexPolygon >> vertices: anObject [
	vertices := anObject
]
