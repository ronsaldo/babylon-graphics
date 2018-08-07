"
I am a mesh part builder that is used for stroking shapes.
"
Class {
	#name : #PompeiiMesh2DStrokeBuilder,
	#superclass : #PompeiiMesh2DPartBuilder,
	#instVars : [
		'width'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #drawing }
PompeiiMesh2DStrokeBuilder >> drawConvexPolygon: convexPolygon [
	"A convex polygon is always closed."
	self drawVertexLoop: convexPolygon vertices.
]

{ #category : #drawing }
PompeiiMesh2DStrokeBuilder >> drawLine: vertices [
	| numVertices |
	builder beginLines.
	
	vertices do: [ :vertex |
		builder addVertex: (evaluator computeVertex: vertex).
	].

	"This is not a loop."
	numVertices := vertices size.
	0 to: numVertices - 2 do: [ :i |
		builder
			addIndex: i;
			addIndex: i + 1
	].

]

{ #category : #drawing }
PompeiiMesh2DStrokeBuilder >> drawLineLoop: vertices [
	| numVertices |
	builder beginLines.
	
	vertices do: [ :vertex |
		builder addVertex: (evaluator computeVertex: vertex).
	].

	numVertices := vertices size.
	0 to: numVertices - 1 do: [ :i |
		builder
			addIndex: i;
			addIndex: (i + 1) % numVertices
	].

]

{ #category : #drawing }
PompeiiMesh2DStrokeBuilder >> drawVertexLine: vertices [
	| previousVertex vertex numVertices nextVertex normal deltaNormal |
	width = 1 ifTrue: [ self drawLine: vertices ].
	builder beginTriangles: currentMaterial.

	previousVertex := vertices first.
	vertex := vertices first.
	numVertices := vertices size.
	0 to: numVertices - 1 do: [ :index |
		nextVertex := vertices at: (index + 1) % vertices size + 1.
		
		normal := (nextVertex - previousVertex) normal.
		deltaNormal := normal * (width*0.5).
		builder
			addVertex: (evaluator computeVertex: vertex - deltaNormal);
			addVertex: (evaluator computeVertex: vertex + deltaNormal).

		previousVertex := vertex.
		vertex := nextVertex.
	].

	0 to: numVertices - 2 do: [ :vi |
		builder
			addIndex: vi*2; addIndex: vi*2 + 1; addIndex: (vi + 1)*2 + 1;
			addIndex: (vi + 1)*2 + 1; addIndex: (vi + 1)*2; addIndex: vi*2
	].
]

{ #category : #drawing }
PompeiiMesh2DStrokeBuilder >> drawVertexLoop: vertices [
	| previousVertex normal vertex nextVertex deltaNormal numVertices |
	width = 1 ifTrue: [ self drawLineLoop: vertices ].
	builder beginTriangles: currentMaterial.

	previousVertex := vertices last.
	vertex := vertices first.
	numVertices := vertices size.
	0 to: numVertices - 1 do: [ :index |
		nextVertex := vertices at: (index + 1) % vertices size + 1.
		
		normal := (nextVertex - previousVertex) normal.
		deltaNormal := normal * (width*0.5).
		builder
			addVertex: (evaluator computeVertex: vertex - deltaNormal);
			addVertex: (evaluator computeVertex: vertex + deltaNormal).

		previousVertex := vertex.
		vertex := nextVertex.
	].

	0 to: numVertices - 2 do: [ :vi |
		builder
			addIndex: vi*2; addIndex: vi*2 + 1; addIndex: (vi + 1)*2 + 1;
			addIndex: (vi + 1)*2 + 1; addIndex: (vi + 1)*2; addIndex: vi*2
	].

	builder
		addIndex: (numVertices - 1)*2; addIndex: (numVertices - 1)*2 + 1; addIndex: 1;
		addIndex: 1; addIndex: 0; addIndex: (numVertices - 1)*2

]

{ #category : #initialization }
PompeiiMesh2DStrokeBuilder >> initialize [
	super initialize.
	width := 1
]

{ #category : #accessing }
PompeiiMesh2DStrokeBuilder >> width [
	^ width
]

{ #category : #accessing }
PompeiiMesh2DStrokeBuilder >> width: anObject [
	width := anObject
]
