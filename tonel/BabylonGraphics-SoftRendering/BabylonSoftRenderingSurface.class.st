Class {
	#name : #BabylonSoftRenderingSurface,
	#superclass : #BabylonSurface,
	#instVars : [
		'transform',
		'currentUnconvertedVertices',
		'currentConvertedVertices',
		'sampleCount',
		'resolveForm',
		'renderBuffer',
		'renderBufferPitch',
		'sampleDistribution',
		'passingSamples',
		'blendingModel'
	],
	#classVars : [
		'MultiSamplingDistributions'
	],
	#category : #'BabylonGraphics-SoftRendering'
}

{ #category : #'class initialization' }
BabylonSoftRenderingSurface class >> computeMultiSamplingDistributionForSize: size [
	| center radius startAngle angle |
	center := 2048@2048.
	radius := 1024.
	startAngle := -45.
	size = 1 ifTrue: [ ^ { center } ].
	
	^ ((1 to: size) collect: [ :i |
		angle := startAngle + (360*(i - 1) / size).
		(radius * angle degreeCos + center x) floor @ (radius * angle degreeSin + center y) floor
	]) , { center }
]

{ #category : #geometry }
BabylonSoftRenderingSurface class >> defaultSampleCount [
	^ 4
]

{ #category : #geometry }
BabylonSoftRenderingSurface class >> extent: anExtent [
	^ self basicNew initializeWithExtent: anExtent sampleCount: self defaultSampleCount
]

{ #category : #'class initialization' }
BabylonSoftRenderingSurface class >> initialize [
	MultiSamplingDistributions := (1 to: 8) collect: [ :i |
		self computeMultiSamplingDistributionForSize: i
	]
]

{ #category : #blending }
BabylonSoftRenderingSurface >> alphaOver [
	blendingModel := BabylonBlendingModeAlphaOver uniqueInstance.
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
	| pixelValue |
	pixelValue := aColor pixelWordForDepth: resolveForm depth.
	1 to: renderBuffer size do: [ :i | renderBuffer at: i put: pixelValue ]
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
	self setSurfaceState.
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
BabylonSoftRenderingSurface >> initializeWithExtent: anExtent sampleCount: aSampleCount [
	self assert: aSampleCount >= 1.
	sampleCount := aSampleCount.
	resolveForm := Form extent: anExtent depth: -32.
	renderBufferPitch := anExtent x * sampleCount.
	sampleDistribution := MultiSamplingDistributions at: sampleCount.
	passingSamples := Array new: sampleCount.

	renderBuffer := sampleCount = 1 ifTrue: [ 
		resolveForm bits.
	] ifFalse: [
		WordArray new: renderBufferPitch * anExtent y.
	].
	self initialize.
]

{ #category : #'drawing commands' }
BabylonSoftRenderingSurface >> resolveRendering [
	| resolveBuffer sourceIndex sampleValue r g b a inverseSampleCount resolvedSample |
	renderBuffer == resolveForm bits ifTrue: [ ^ self ].
	
	resolveForm unhibernate.
	resolveBuffer := resolveForm bits.
	sourceIndex := 1.
	inverseSampleCount := 1.0 / sampleCount.
	1 to: resolveBuffer size do: [ :destIndex |
		r := 0.0.
		g := 0.0.
		b := 0.0.
		a := 0.0.

		1 to: sampleCount do: [ :sampleIndex |
			sampleValue := renderBuffer at: sourceIndex.
			
			b := b + (sampleValue & 16rff) babylonDecodeSRGBColorChannel.
			g := g + ((sampleValue >> 8) & 16rff) babylonDecodeSRGBColorChannel.
			r := r + ((sampleValue >> 16) & 16rff) babylonDecodeSRGBColorChannel.
			a := a + ((sampleValue >> 24) & 16rff) babylonDecodeLinearChannel.
			sourceIndex := sourceIndex + 1.
		].
	
		r := (r * inverseSampleCount) babylonEncodeLinearToSRGBColorChannel.
		g := (g * inverseSampleCount) babylonEncodeLinearToSRGBColorChannel.
		b := (b * inverseSampleCount) babylonEncodeLinearToSRGBColorChannel.
		a := (a * inverseSampleCount) babylonEncodeColorChannel.
	
		resolvedSample := b | (g << 8) | (r << 16) | (a <<24).
		resolveBuffer at: destIndex put: resolvedSample
	].

]

{ #category : #initialization }
BabylonSoftRenderingSurface >> setSurfaceState [
	transform loadIdentity.
	self alphaOver
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
	| formExtent width height p1 p2 p3 minX minY maxX maxY area inverseArea destBits p destRow fragmentValue destIndex w1 w2 w3 f1 f2 f3 pixelPoint sampleDistributionSize sampleOffset passingSampleCount |
	p1 := v1 position.
	p2 := v2 position.
	p3 := v3 position.
	
	formExtent := resolveForm extent.
	width := formExtent x.
	height := formExtent y.
	minX := ((p1 x min: p2 x) min: p3 x) max: 0.
	minY := ((p1 y min: p2 y) min: p3 y) max: 0.
	maxX := ((p1 x max: p2 x) max: p3 x) min: (width - 1) << 12.
	maxY := ((p1 y max: p2 y) max: p3 y) min: (height - 1) << 12.
	
	minX := minX & -4096.
	minY := minY & -4096.
	maxX := (maxX + 4095) & -4096.
	maxY := (maxY + 4095) & -4096.

	area := self barycentricAt: p1 forSegmentFrom: p2 to: p3.
	(area closeTo: 0.0) ifTrue: [ ^ self ].
	inverseArea := 1.0 / area.

	renderBuffer == resolveForm bits ifTrue: [ 
		resolveForm unhibernate.
	].
	destBits := renderBuffer.

	p := BabylonMutablePoint new.

	renderBufferPitch := width*sampleCount.
	sampleDistributionSize := sampleDistribution size.
	
	destRow := ((minY >> 12) * renderBufferPitch) + ((minX >> 12)*sampleCount) + 1.
	fragmentValue := BabylonLinearColor new.
	minY to: maxY - 4096 by: 4096 do: [ :y |
		destIndex := destRow.
		minX to: maxX - 4096 by: 4096 do: [ :x |
			passingSampleCount := 0.
			1 to: sampleDistributionSize do: [ :sampleIndex |
				sampleOffset := sampleDistribution at: sampleIndex.
				p x: x + sampleOffset x.
				p y: y + sampleOffset y.

				w1 := self barycentricAt: p forSegmentFrom: p2 to: p3.
				w2 := self barycentricAt: p forSegmentFrom: p3 to: p1.
				w3 := self barycentricAt: p forSegmentFrom: p1 to: p2.
				
				sampleIndex <= sampleCount ifTrue: [
					(w1 | w2 | w3 > 0) ifTrue: [
						passingSampleCount := passingSampleCount + 1.
						passingSamples at: sampleIndex put: true
					] ifFalse: [ 
						passingSamples at: sampleIndex put: false
					]
				].
			].
		
			passingSampleCount >= 1 ifTrue: [
				f1 := w1 * inverseArea.
				f2 := w2 * inverseArea.
				f3 := w3 * inverseArea.
				
				pixelPoint := p fromFixedPointForBabylonRendering.
				shader valueWithArguments: {pixelPoint . f1 . f2 . f3 . fragmentValue}.
			].

			1 to: sampleCount do: [ :sampleIndex |
				(passingSamples at: sampleIndex) ifTrue: [
					blendingModel renderBuffer: destBits at: destIndex blendWithLinearColor: fragmentValue
				].
				destIndex := destIndex + 1
			].
		].
	
		destRow := destRow + renderBufferPitch
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
