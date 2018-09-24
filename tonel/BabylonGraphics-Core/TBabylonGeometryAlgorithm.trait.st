Trait {
	#name : #TBabylonGeometryAlgorithm,
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #geometry }
TBabylonGeometryAlgorithm >> areVerticesCollinear: vertices [
	3 to: vertices size do: [ :i |
		(self isTriangleCollinear: (vertices at: i - 2) position p2: (vertices at: i - 1) position p3: (vertices at: i) position) ifFalse: [
			^ false
		]
	].

	^ true
]

{ #category : #'geometry testing' }
TBabylonGeometryAlgorithm >> areaOfTriangleP1: p1 p2: p2 p3: p3 [
	^ self crossWithReference: p1 first: p2 second: p3
]

{ #category : #geometry }
TBabylonGeometryAlgorithm >> cross: u with: v [
	^ (u x * v y) - (u y * v x)
]

{ #category : #geometry }
TBabylonGeometryAlgorithm >> crossWithReference: referencePoint first: first second: second [
	| u v |
	u := first - referencePoint.
	v := second - referencePoint.
	^ self cross: u with: v
]

{ #category : #'geometry testing' }
TBabylonGeometryAlgorithm >> isTriangleCollinear: p1 p2: p2 p3: p3 [
	^ (self areaOfTriangleP1: p1 p2: p2 p3: p3) closeTo: 0
]
