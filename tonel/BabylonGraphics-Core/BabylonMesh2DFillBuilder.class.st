"
I am a mesh part builder that is used for filling shapes.
"
Class {
	#name : #BabylonMesh2DFillBuilder,
	#superclass : #BabylonMesh2DPartBuilder,
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #drawing }
BabylonMesh2DFillBuilder >> drawConvexPolygon: convexPolygon [
	| numVertices |
	builder beginTriangles: currentMaterial.
	
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
