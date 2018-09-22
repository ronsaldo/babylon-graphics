Class {
	#name : #BabylonSoftRenderingSurface,
	#superclass : #BabylonSurface,
	#instVars : [
		'transform',
		'currentUnconvertedVertices',
		'currentConvertedVertices',
		'sampleCount',
		'renderForm',
		'resolveForm',
		'resolutionMultiplier'
	],
	#category : #'BabylonGraphics-SoftRendering'
}

{ #category : #geometry }
BabylonSoftRenderingSurface class >> defaultSampleCount [
	^ 4
]

{ #category : #geometry }
BabylonSoftRenderingSurface class >> extent: anExtent [
	^ self basicNew initializeWithExtent: anExtent sampleCount: self defaultSampleCount
]

{ #category : #converting }
BabylonSoftRenderingSurface >> asForm [
	self resolveRendering.
	^ resolveForm
]

{ #category : #geometry }
BabylonSoftRenderingSurface >> barycentricAt: p forSegmentFrom: start to: end [
	^ self computeTriangleOrientationP1: start p2: end p3: p
]

{ #category : #'drawing commands' }
BabylonSoftRenderingSurface >> clear: aColor [
	renderForm fillColor: aColor
]

{ #category : #geometry }
BabylonSoftRenderingSurface >> computeTriangleOrientationP1: p1 p2: p2 p3: p3 [
	| ux uy vx vy |
	ux := p2 x - p1 x.
	uy := p2 y - p1 y.
	
	vx := p3 x - p1 x.
	vy := p3 y - p1 y.
	
	^ (ux * vy) - (uy * vx)
]

{ #category : #drawing }
BabylonSoftRenderingSurface >> drawDuring: aBlock [
	| canvas |
	canvas := BabylonSoftRenderingCanvas new surface: self.
	aBlock value: canvas
]

{ #category : #accessing }
BabylonSoftRenderingSurface >> driver [
	^ BabylonSoftRenderingDriver uniqueInstance
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> evaluateLineV1: v1 v2: v2 [
	self flag: 'TODO: Implement myself.'
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> evaluateTriangleV1: v1 v2: v2 v3: v3 [
	| cr cg cb ca |
	^ self shadeTriangleV1: v1 v2: v2 v3: v3 with: [ :p :vw1 :vw2 :vw3 :output |
		cr := (v1 color r * vw1) + (v2 color r * vw2) + (v3 color r * vw3).
		cg := (v1 color g * vw1) + (v2 color g * vw2) + (v3 color g * vw3).
		cb := (v1 color b * vw1) + (v2 color b * vw2) + (v3 color b * vw3).
		ca := (v1 color a * vw1) + (v2 color a * vw2) + (v3 color a * vw3).
		output r: cr g: cg b: cb a: ca
	]
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> evaluateVertexIndex: index [
	| convertedVertex |
	(currentConvertedVertices at: index + 1) ifNotNil: [ :vertex | ^ vertex ].
	
	convertedVertex := self transformVertex: (currentUnconvertedVertices at: index +1).
	currentConvertedVertices at: index + 1 put: convertedVertex.
	^ convertedVertex
]

{ #category : #initialization }
BabylonSoftRenderingSurface >> initialize [
	super initialize.
	transform := BabylonAffineTransform new.
]

{ #category : #initialization }
BabylonSoftRenderingSurface >> initializeWithExtent: anExtent [
	renderForm := Form extent: anExtent depth: -32.
	self initialize.
]

{ #category : #initialization }
BabylonSoftRenderingSurface >> initializeWithExtent: anExtent sampleCount: aSampleCount [
	sampleCount := aSampleCount.
	resolveForm := Form extent: anExtent depth: -32.
	resolutionMultiplier := sampleCount sqrtFloor.
	renderForm := resolveForm.
	resolutionMultiplier > 1 ifTrue: [ 
		renderForm := Form extent: anExtent * resolutionMultiplier depth: -32.
	].
	self initialize.
]

{ #category : #'drawing commands' }
BabylonSoftRenderingSurface >> resolveRendering [
	renderForm == resolveForm ifTrue: [ ^ self ].
	self flag: 'TODO: Move this into a FFI called library.'.
	(WarpBlt toForm: resolveForm)
		sourceForm: renderForm;
		colorMap: renderForm colormapFromARGB;
		cellSize: 2;
		"installs a new colormap if cellSize > 1"
			combinationRule: 3;
		copyQuad: renderForm boundingBox innerCorners toRect: resolveForm boundingBox
]

{ #category : #initialization }
BabylonSoftRenderingSurface >> setSurfaceState [
	transform loadIdentity
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> shadeCCWTriangleV1: v1 v2: v2 v3: v3 with: shader [
"
	Triangle Rasterization algorithm from:
	https://fgiesen.wordpress.com/2013/02/17/optimizing-sw-occlusion-culling-index/
	https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/
	https://fgiesen.wordpress.com/2013/02/08/triangle-rasterization-in-practice/
	https://fgiesen.wordpress.com/2013/02/10/optimizing-the-basic-rasterizer/
"
	| formExtent width height p1 p2 p3 minX minY maxX maxY area inverseArea destBits p destPitch pixelDeltaLength destRow fragmentValue destIndex w1 w2 w3 f1 f2 f3 pixelPoint |
	p1 := v1 position.
	p2 := v2 position.
	p3 := v3 position.
	
	formExtent := resolveForm extent.
	width := formExtent x.
	height := formExtent y.
	minX := (p1 x min: p2 x) min: p3 x.
	minY := (p1 y min: p2 y) min: p3 y.
	maxX := (p1 x max: p2 x) max: p3 x.
	maxY := (p1 y max: p2 y) max: p3 y.
	
	minX < 0 ifTrue: [ minX := minX & 1023 ].
	minY < 0 ifTrue: [ minY := minY & 1023 ].
	maxX := maxX min: (width - 1) << 12.
	maxY := maxY min: (height - 1) << 12.

	area := self barycentricAt: p1 forSegmentFrom: p2 to: p3.
	(area closeTo: 0.0) ifTrue: [ ^ self ].
	inverseArea := 1.0 / area.

	renderForm unhibernate.
	destBits := renderForm bits.

	p := BabylonMutablePoint new.

	destPitch := width*resolutionMultiplier.
	pixelDeltaLength := 1024/resolutionMultiplier.
	
	destRow := ((minY >> 12) * destPitch) + (minX >> 12) + 1.	
	fragmentValue := BabylonLinearColor new.
	minY to: maxY by: pixelDeltaLength do: [ :y |
		destIndex := destRow.
		minX to: maxX by: pixelDeltaLength do: [ :x |
			p x: x.
			p y: y.
			
			w1 := self barycentricAt: p forSegmentFrom: p2 to: p3.
			w2 := self barycentricAt: p forSegmentFrom: p3 to: p1.
			w3 := self barycentricAt: p forSegmentFrom: p1 to: p2.

			(w1 >= 0.0 and: [w2 >= 0.0 and: [w3 >= 0.0]])
			"(w1 | w2 | w3 > 0.0)" ifTrue: [
				f1 := w1 * inverseArea.
				f2 := w2 * inverseArea.
				f3 := w3 * inverseArea.
				
				pixelPoint := p fromFixedPointForBabylonRendering.
				shader valueWithArguments: {pixelPoint . f1 . f2 . f3 . fragmentValue}.
				destBits at: destIndex put: fragmentValue asBGRA32
			].
		
			destIndex := destIndex + 1
		].
	
		destRow := destRow + destPitch
	].
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> shadeTriangleV1: v1 v2: v2 v3: v3 with: shader [
	| orientation |
	orientation := self computeTriangleOrientationP1: v1 position p2: v2 position p3: v3 position.
	(orientation closeTo: 0.0) ifTrue: [ ^ self ].
	orientation < 0.0 ifTrue: [
		^ self evaluateTriangleV1: v1 v2: v3 v3: v2
	].

	^ self shadeCCWTriangleV1: v1 v2: v2 v3: v3 with: shader

]

{ #category : #accessing }
BabylonSoftRenderingSurface >> transform [
	^ transform
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> transformVertex: aVertex [
	^ aVertex shallowCopy
		position: (transform transform: aVertex position) asFixedPointForBabylonRendering;
		color: aVertex color asBabylonLinearColor;
		yourself
]

{ #category : #'primitive evaluation' }
BabylonSoftRenderingSurface >> withVertices: vertices do: aBlock [
	currentUnconvertedVertices := vertices.
	currentConvertedVertices := Array new: vertices size.
	aBlock ensure: [
		currentUnconvertedVertices := nil.
		currentConvertedVertices := nil.
	]
]
