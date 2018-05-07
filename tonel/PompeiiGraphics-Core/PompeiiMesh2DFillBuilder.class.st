"
I am a mesh part builder that is used for filling shapes.
"
Class {
	#name : #PompeiiMesh2DFillBuilder,
	#superclass : #PompeiiMesh2DPartBuilder,
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #drawing }
PompeiiMesh2DFillBuilder >> drawConvexPolygon: convexPolygon [
	| numVertices |
	builder beginTriangles.
	
	convexPolygon vertices do: [ :vertex |
		builder addVertex: (evaluator computeVertex: vertex)
	].

	numVertices := convexPolygon vertices size.
	2 to: numVertices - 1 do: [ :index |
		builder
			addIndex: 0;
			addIndex: index - 1;
			addIndex: index
	].

]
