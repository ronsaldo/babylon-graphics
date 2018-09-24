Class {
	#name : #BabylonDelaunayTriangulator,
	#superclass : #Object,
	#traits : 'TBabylonGeometryAlgorithm',
	#classTraits : 'TBabylonGeometryAlgorithm classTrait',
	#instVars : [
		'triangles'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator class >> triangulatePoints: aCollectionOfPoints [
	^ self new triangulatePoints: aCollectionOfPoints
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> addVertexIntoTriangulation: vertex [
	| t1 t2 t3 v1 v2 v3 ot2 ot3 p1 p2 p3 point |
	t1 := self findTriangleContainingVertex: vertex.

	v1 := t1 v1. p1 := v1 position.
	v2 := t1 v2. p2 := v2 position.
	v3 := t1 v3. p3 := v3 position.
	point := vertex position.
	
	(self isTriangleCollinear: p1 p2: p2 p3: point) ifTrue: [ 
		^ self splitTriangle: t1 segment: 1 withVertex: vertex
	].

	(self isTriangleCollinear: p2 p2: p3 p3: point) ifTrue: [ 
		^ self splitTriangle: t1 segment: 2 withVertex: vertex
	].

	(self isTriangleCollinear: p3 p2: p1 p3: point) ifTrue: [ 
		^ self splitTriangle: t1 segment: 3 withVertex: vertex
	].
	
	t2 := BabylonDelaunayTriangulatorTriangle new. triangles add: t2.
	t3 := BabylonDelaunayTriangulatorTriangle new. triangles add: t3.
	
	ot2 := t1	 t2.
	ot3 := t1	 t3.
	
	t1
		"v1: v1; t1: ot1;"
		v2: v2; t2: t2;
		v3: vertex; t3: t3.

	t2
		v1: v2; t1: ot2;
		v2: v3; t2: t3;
		v3: vertex; t3: t1.
	ot2 ifNotNil: [ ot2 replaceNeighbor: t1 with: t2 ].

	t3
		v1: v3; t1: ot3;
		v2: v1; t2: t1;
		v3: vertex; t3: t2.
		ot3 ifNotNil: [ ot3 replaceNeighbor: t1 with: t3 ].
		
	self
		legalizeTriangle: t1;
		legalizeTriangle: t2;
		legalizeTriangle: t3
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> computeBoundingBoxOfVertices: vertices [
	| minX minY maxX maxY position width height |
	minX := Float infinity.
	minY := Float infinity.
	maxX := Float negativeInfinity.
	maxY := Float negativeInfinity.
	
	vertices do: [ :vertex |
		position := vertex position.
		minX := minX min: position x.
		minY := minY min: position y.
		maxX := maxX max: position x.
		maxY := maxY max: position y.
	].

	width := maxX - minX.
	height := maxY - minY.
	
	minX := minX - (width*2).
	minY := minY - (height*2).
	maxX := maxX + (width*2).
	maxY := maxY + (height*2).
	^ {
		BabylonDelaunayTriangulatorVertex new position: minX@minY.
		BabylonDelaunayTriangulatorVertex new position: maxX@minY.
		BabylonDelaunayTriangulatorVertex new position: maxX@maxY.
		BabylonDelaunayTriangulatorVertex new position: minX@maxY.
	}
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> findTriangleContainingVertex: vertex [
	| point oldSearchPosition newSearchPosition |
	point := vertex position.
	oldSearchPosition := nil.
	newSearchPosition := triangles first.
	
	[
		oldSearchPosition := newSearchPosition.
		newSearchPosition := self nextTriangleContainingPoint: point startingFrom: oldSearchPosition
	] doWhileTrue: [ oldSearchPosition ~~ newSearchPosition ].
	^ newSearchPosition
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> flipTriangle: triangle segment: segmentIndex neighbor: neighbor segment: neighborSegment [
	| tv1 tv2 tv3 nv1 nv2 nv3 v1 t1 v2 t2 v3 t3 v4 t4 lower upper |
	tv1 := triangle vertexAt: segmentIndex.
	tv2 := triangle vertexAt: segmentIndex + 1.
	tv3 := triangle vertexAt: segmentIndex + 2.
	
	nv1 := neighbor vertexAt: neighborSegment.
	nv2 := neighbor vertexAt: neighborSegment + 1.
	nv3 := neighbor vertexAt: neighborSegment + 2.
	
	v1 := tv3. t1 := triangle neighborAtSegment: segmentIndex + 2.
	v2 := tv1. t2 := neighbor neighborAtSegment: neighborSegment + 1. self assert: tv1 == nv2.
	v3 := nv3. t3 := neighbor neighborAtSegment: neighborSegment + 2.
	v4 := tv2. t4 := triangle neighborAtSegment: segmentIndex + 1. self assert: tv2 == nv1.
	
	lower := triangle.
	upper := neighbor.
	
	t1 ifNotNil: [ t1 replaceNeighbor: triangle with: lower ].
	t2 ifNotNil: [ t2 replaceNeighbor: neighbor with: lower ].
	t3 ifNotNil: [ t3 replaceNeighbor: neighbor with: upper ].
	t4 ifNotNil: [ t4 replaceNeighbor: triangle with: upper ].
	
	lower
		v1: v1; t1: t1;
		v2: v2; t2: t2;
		v3: v3; t3: upper.
	upper
		v1: v3; t1: t3;
		v2: v4; t2: t4;
		v3: v1; t3: lower.

]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> legalizeTriangle: triangle [
	| p1 p2 p3 neighbor neighborSegment opposite |
	p1 := triangle v1 position.
	p2 := triangle v2 position.
	p3 := triangle v3 position.
	
	1 to: 3 do: [ :segmentIndex |
		neighbor := triangle neighborAtSegment: segmentIndex.
		neighbor ifNotNil: [ 
			neighborSegment := neighbor findNeighborSegment: triangle.
			opposite := neighbor vertexAt: neighborSegment + 2.
			(self testTriangle: p1 b: p2 c: p3 withPoint: opposite position) ifTrue: [
				^ self flipTriangle: triangle segment: segmentIndex neighbor: neighbor segment: neighborSegment
			]
		].
	].

]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> nextTriangleContainingPoint: point startingFrom: triangle [
	| p1 p2 p3 |
	p1 := triangle v1 position.
	p2 := triangle v2 position.
	(self crossWithReference: p1 first: p2 second: point) < 0 ifTrue: [
		^ triangle t1
	].

	p3 := triangle v3 position.
	(self crossWithReference: p2 first: p3 second: point) < 0 ifTrue: [
		^ triangle t2
	].
	(self crossWithReference: p3 first: p1 second: point) < 0 ifTrue: [
		^ triangle t3
	].

	^ triangle
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> splitTriangle: triangle segment: segmentIndex withVertex: vertex [
	| neighbor topLeft topRight bottomLeft bottomRight v1 v2 v3 neighborSegmentIndex nv1 nv2 nv3 |
	neighbor := triangle neighborAtSegment: segmentIndex.
		
	v1 := triangle vertexAt: segmentIndex.
	v2 := triangle vertexAt: segmentIndex + 1.
	v3 := triangle vertexAt: segmentIndex + 2.
	
	topLeft := triangle.
	topRight := BabylonDelaunayTriangulatorTriangle new.
	triangles add: topRight.

	bottomLeft := nil.
	bottomRight := nil.
	neighbor ifNotNil: [
		bottomLeft := BabylonDelaunayTriangulatorTriangle new.
		bottomRight := neighbor.
		triangles add: bottomLeft.
	].

	topRight
		v1: vertex; t1: bottomRight;
		v2: v2; t2: (topLeft neighborAtSegment: segmentIndex + 1);
		v3: v3; t3: topLeft.

	(topLeft neighborAtSegment: segmentIndex + 1) ifNotNil: [:n | n replaceNeighbor: topLeft with: topRight].
	topLeft
		vertexAt: segmentIndex + 1 put: vertex;
		neighborAtSegment: segmentIndex + 1 put: topRight.
	
	neighbor ifNotNil: [
		neighborSegmentIndex := neighbor findNeighborSegment: triangle.
		nv1 := neighbor vertexAt: neighborSegmentIndex.
		nv2 := neighbor vertexAt: neighborSegmentIndex + 1.
		nv3 := neighbor vertexAt: neighborSegmentIndex + 2.
		
		self assert: v1 == nv2.
		self assert: nv1 == v2.

		topLeft neighborAtSegment: segmentIndex put: bottomLeft.
		bottomRight neighborAtSegment: neighborSegmentIndex put: topRight.
		
		bottomLeft
			v1: vertex; t1: topLeft;
			v2: nv2; t2: (bottomRight neighborAtSegment: neighborSegmentIndex + 1);
			v3: nv3; t3: bottomRight.

		(bottomRight neighborAtSegment: neighborSegmentIndex + 1) ifNotNil: [:n | n replaceNeighbor: bottomRight with: bottomLeft ].
		bottomRight
			vertexAt: neighborSegmentIndex + 1 put: vertex;
			neighborAtSegment: neighborSegmentIndex + 1 put: bottomLeft.
	].

	self
		legalizeTriangle: topLeft;
		legalizeTriangle: topRight.
	neighbor ifNotNil: [ 
		self
			legalizeTriangle: bottomLeft;
			legalizeTriangle: bottomRight.
	].
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> testTriangle: a b: b c: c withPoint: d [
	"https://en.wikipedia.org/wiki/Delaunay_triangulation"
	| m11 m12 m13 m21 m22 m23 m31 m32 m33 det |
	m11 := a x - d x. m12 := a y - d y. m13 := (a x - d x) squared + (a y - d y) squared.
	m21 := b x - d x. m22 := b y - d y. m23 := (b x - d x) squared + (b y - d y) squared.
	m31 := c x - d x. m32 := c y - d y. m33 := (c x - d x) squared + (c y - d y) squared.
	det := (m11*m22*m33) + (m12*m23*m31) + (m13*m21*m32)
	- (m31*m22*m13) - (m32*m23*m11) - (m33*m21*m12).
	^ det > 0
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> triangulatePoints: aCollectionOfPoints [
	^ self triangulateVertices: (aCollectionOfPoints collectWithIndex: [ :point :index |
		BabylonDelaunayTriangulatorVertex new position: point; index: index
	])
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulator >> triangulateVertices: vertices [
	| bbox t1 t2 |
	bbox := self computeBoundingBoxOfVertices: vertices.
	triangles := OrderedCollection new.
	t1 := BabylonDelaunayTriangulatorTriangle new.
	t2 := BabylonDelaunayTriangulatorTriangle new.
	
	t1 v1: bbox first;
		v2: bbox second;
		v3: bbox third; t3: t2.
	t2 v1: bbox third;
		v2: bbox fourth;
		v3: bbox first; t3: t1.
	triangles add: t1; add: t2.
	
	vertices do:  [ :vertex |
		self addVertexIntoTriangulation: vertex
	].

	^ BabylonDelaunayTriangulation new
		vertices: vertices;
		triangles: (triangles select: #hasVerticesWithIndices);
		"triangles: triangles;"
		yourself
]
