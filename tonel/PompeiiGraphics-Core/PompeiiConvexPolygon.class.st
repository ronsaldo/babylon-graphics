"
I represent a closed convex polygon.
"
Class {
	#name : #PompeiiConvexPolygon,
	#superclass : #PompeiiShape,
	#instVars : [
		'vertices'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #construction }
PompeiiConvexPolygon class >> build: aBlock [
	| builder |
	builder := PompeiiConvexPolygonBuilder new.
	aBlock value: builder.
	^ builder polygon
]

{ #category : #construction }
PompeiiConvexPolygon class >> convexHull: aCollectionOfPoints [
	^ self vertices: (PompeiiConvexHull points: aCollectionOfPoints)

]

{ #category : #construction }
PompeiiConvexPolygon class >> radius: radius center: center sides: sides [
	^ self radius: radius center: center sides: sides phase: 0
]

{ #category : #construction }
PompeiiConvexPolygon class >> radius: radius center: center sides: sides phase: anglePhase [
	| angle x y |
	^ self vertices: ((1 to: sides) collect: [ :i |
		angle := (i - 1) / sides * Float twoPi + anglePhase.
		x := radius * (angle cos).
		y := radius * (angle sin).
		(x + center x) @ (y + center y)
	])
]

{ #category : #construction }
PompeiiConvexPolygon class >> radius: radius sides: sides [
	^ self radius: radius center: 0@0 sides: sides phase: 0
]

{ #category : #construction }
PompeiiConvexPolygon class >> rectangle: aRectangle [
	^ self vertices: {
		aRectangle topLeft . aRectangle topRight .
		aRectangle bottomRight . aRectangle bottomLeft
	}

]

{ #category : #construction }
PompeiiConvexPolygon class >> rectangle: aRectangle round: radius [
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
PompeiiConvexPolygon class >> vertices: anArrayOfVertices [
	^ self new vertices: anArrayOfVertices
]

{ #category : #arithmetic }
PompeiiConvexPolygon >> + otherPolygon [
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
PompeiiConvexPolygon >> - otherPolygon [
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
PompeiiConvexPolygon >> asPompeiiShapeFor: aPompeiiDriver [
	^ aPompeiiDriver convertPolygon: self
]

{ #category : #converting }
PompeiiConvexPolygon >> asWavefrontOBJ [
	^ ByteString streamContents: [ :out |
		self saveWavefrontOBJInto: out
	]
]

{ #category : #accessing }
PompeiiConvexPolygon >> boundingBox [
	^ Rectangle encompassing: vertices
]

{ #category : #'as yet unclassified' }
PompeiiConvexPolygon >> drawWithBuilder: aBuilder [
	^ aBuilder drawConvexPolygon: self
]

{ #category : #converting }
PompeiiConvexPolygon >> saveWavefrontOBJ: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate.
		self saveWavefrontOBJInto: out
	]
]

{ #category : #converting }
PompeiiConvexPolygon >> saveWavefrontOBJInto: out [
	vertices do: [ :vertex |
		out nextPutAll: 'v '; print: vertex x; space; print: vertex y; nextPutAll: ' 0'; lf
	].

	1 to: vertices size do: [ :i |
		out nextPutAll: 'f '; print: i; space; print: (i % vertices size) + 1; lf
	]	

]

{ #category : #accessing }
PompeiiConvexPolygon >> vertices [
	^ vertices
]

{ #category : #accessing }
PompeiiConvexPolygon >> vertices: anObject [
	vertices := anObject
]
