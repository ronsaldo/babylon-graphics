Class {
	#name : #BabylonSurfaceExamples,
	#superclass : #Object,
	#category : #'BabylonGraphics-Examples'
}

{ #category : #'as yet unclassified' }
BabylonSurfaceExamples class >> driver [
	^ BabylonDriver current
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleBlueSurface [
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color blue
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleCircle [
	| builder mesh shape |
	builder := BabylonMesh2DBuilder new.
	shape := BabylonConvexPolygon radius: 60 center: 80@80 sides: 32.
	
	builder fill
		gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
		draw: shape.
	builder stroke
		color: (Color black alpha: 0.5);
		width: 3;
		draw: shape.
	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleComplexMesh [
	| builder mesh triangleShape rectangleShape|
	builder := BabylonMesh2DBuilder new.
		
	builder transform restoreAfter: [
		builder transform translateX: 100 Y: 50.

		triangleShape := BabylonConvexPolygon radius: 60 center: 0@0 sides: 3 phase: Float halfPi.
		builder fill
			gradientStart: 0@ -30 color: Color cyan end: 0@60 color: Color blue;
			draw: triangleShape.
		builder stroke
			color: (Color black alpha: 0.5);
			width: 3;
			draw: triangleShape.
	].

	builder transform restoreAfter: [
		builder transform translateX: 100 Y: 150.

		rectangleShape := BabylonConvexPolygon rectangle: (0@0 extent: 120@120) round: 15.
		builder fill
			gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
			draw: rectangleShape.
		builder stroke
			color: (Color black alpha: 0.5);
			width: 3;
			draw: rectangleShape.
	].

	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleRectangle [
	| builder mesh |
	builder := BabylonMesh2DBuilder new.
	builder fill
		gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
		rectangle: (0@0 extent: 128@128) round: 15.
	builder stroke
		color: (Color black alpha: 0.5);
		width: 3;
		rectangle: (0@0 extent: 128@128) round: 15.
	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas transform restoreAfter: [
				canvas transform translateX: 30 y: 50.
				canvas draw: mesh
			].
			
			canvas transform restoreAfter: [
				canvas transform translateX: 200 y: 50.
				canvas draw: mesh
			]
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleRoundedTriangle [
	| builder mesh shape |
	builder := BabylonMesh2DBuilder new.
	shape := (BabylonConvexPolygon radius: 60 center: 80@80 sides: 3 phase: Float halfPi) + (BabylonConvexPolygon radius: 15 sides: 16).
	
	builder fill
		gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
		draw: shape.
	builder stroke
		color: (Color black alpha: 0.5);
		width: 3;
		draw: shape.
	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleSurfaceDo: aBlock [
	| driver surface |
	driver := self driver.
	surface := driver surfaceWithExtent: 640@480.
	aBlock value: surface.
	
	surface asForm asMorph openInWindow
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleText [
	| builder mesh font |
	
	self exampleSurfaceDo: [ :surface |
		font := surface driver font: (LogicalFont familyName: 'Arial' pointSize: 20).
		
		builder := surface driver mesh2DBuilder.
		builder text
			color: Color black;
			font: font;
			position: (0 @ font getPreciseAscent);
			draw: 'Hello ';
			color: Color red;
			draw: 'World!'.
		mesh := builder mesh.
	
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleTextAndRectangle [
	| builder mesh font |
	
	self exampleSurfaceDo: [ :surface |
		font := surface driver font: (LogicalFont familyName: 'Arial' pointSize: 20).
		
		builder := surface driver mesh2DBuilder.
		builder fill
			gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
			rectangle: (0@0 extent: 128@128) round: 15.
		builder stroke
			color: (Color black alpha: 0.5);
			width: 3;
			rectangle: (0@0 extent: 128@128) round: 15.
		builder text
			color: Color black;
			font: font;
			position: (30 @ (30 + font getPreciseAscent));
			draw: 'Hello ';
			color: Color red;
			draw: 'World!'.
		mesh := builder mesh.
	
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleTriangle [
	| builder mesh shape |
	builder := BabylonMesh2DBuilder new.
	shape := BabylonConvexPolygon radius: 60 center: 80@80 sides: 3 phase: Float halfPi.
	
	builder fill
		gradientStart: 0@0 color: Color cyan end: 0@128 color: Color blue;
		draw: shape.
	builder stroke
		color: (Color black alpha: 0.5);
		width: 3;
		draw: shape.
	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]

{ #category : #'instance creation' }
BabylonSurfaceExamples class >> exampleTriangleGradient [
	| builder mesh |
	builder := BabylonMesh2DBuilder new.
	
	builder
		beginTriangles;
		addVertex: (100@300) color: Color red;
		addVertex: (600@300) color: Color green;
		addVertex: (300@50) color: Color blue;
		addIndex: 0; addIndex: 1; addIndex: 2.
	mesh := builder mesh.
	
	self exampleSurfaceDo: [ :surface |
		surface drawDuring: [ :canvas |
			canvas clear: Color white.
			canvas draw: mesh
		]
	]
]
