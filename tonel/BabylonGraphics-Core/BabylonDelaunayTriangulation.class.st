Class {
	#name : #BabylonDelaunayTriangulation,
	#superclass : #Object,
	#instVars : [
		'vertices',
		'triangles'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #'instance creation' }
BabylonDelaunayTriangulation class >> fromPoints: aCollectionfPoints [
	^ BabylonDelaunayTriangulator triangulatePoints: aCollectionfPoints
]

{ #category : #visualization }
BabylonDelaunayTriangulation >> gtInspectorVisualizationIn: composite [
	<gtInspectorPresentationOrder: 0>  
	^ composite morph 
		title: 'Triangulation';
		display: [ self visualizationWithExtent: 400@400 ]
]

{ #category : #initialization }
BabylonDelaunayTriangulation >> initialize [
	super initialize.
	triangles := #().
	vertices := #().
	
]

{ #category : #initialization }
BabylonDelaunayTriangulation >> isEmpty [
	^ triangles isEmpty
]

{ #category : #initialization }
BabylonDelaunayTriangulation >> isNotEmpty [
	^ triangles isNotEmpty
]

{ #category : #accessing }
BabylonDelaunayTriangulation >> triangles [
	^ triangles
]

{ #category : #accessing }
BabylonDelaunayTriangulation >> triangles: anObject [
	triangles := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulation >> vertices [
	^ vertices
]

{ #category : #accessing }
BabylonDelaunayTriangulation >> vertices: anObject [
	vertices := anObject
]

{ #category : #visualization }
BabylonDelaunayTriangulation >> visualizationMesh [
	| builder stroker filler vertexSize |
	builder := BabylonMesh2DBuilder new.
	stroker := builder stroke
		color: Color black;
		width: 3;
		yourself.
	triangles do: [ :triangle |
		triangle isValidTriangle ifTrue: [ 
			stroker drawVertexLoop: triangle positions
		] ifFalse: [
			(triangle v1 isNotNil and: [ triangle v2 isNotNil ]) ifTrue: [ 
				stroker drawVertexLine: {triangle v1 position . triangle v2 position}.
			].
			(triangle v2 isNotNil and: [ triangle v3 isNotNil ]) ifTrue: [ 
				stroker drawVertexLine: {triangle v2 position . triangle v3 position}.
			].
			(triangle v3 isNotNil and: [ triangle v3 isNotNil ]) ifTrue: [ 
				stroker drawVertexLine: {triangle v1 position . triangle v3 position}.
			].
		].
	].

	filler := builder fill
		color: Color green.
	vertexSize := 3@3.
	vertices do: [ :vertex |
		filler rectangle: (vertex position - vertexSize corner: vertex position + vertexSize)
	].


	^ builder mesh
]

{ #category : #visualization }
BabylonDelaunayTriangulation >> visualizationWithExtent: extent [
	| mesh surface |
	mesh := self visualizationMesh.

	surface := BabylonDriver current surfaceWithExtent: extent.
	surface drawDuring: [ :canvas | 
		canvas clear: Color white.
		canvas transform restoreAfter: [
			canvas transform
				scaleX: 1.0 Y: -1.0;
				translateX: extent x // 2 y: extent y // -2.
			canvas draw: mesh
		]
	].

	^ surface asForm
]
