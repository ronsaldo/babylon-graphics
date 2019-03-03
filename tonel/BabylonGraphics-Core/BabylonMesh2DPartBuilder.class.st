"
I am used to build a part of a 2D mesh.
"
Class {
	#name : #BabylonMesh2DPartBuilder,
	#superclass : #Object,
	#instVars : [
		'builder',
		'evaluator',
		'currentMaterial'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #accessing }
BabylonMesh2DPartBuilder >> builder [
	^ builder
]

{ #category : #accessing }
BabylonMesh2DPartBuilder >> builder: anObject [
	builder := anObject.
	self color: Color black.
]

{ #category : #color }
BabylonMesh2DPartBuilder >> color: aColor [
	evaluator := BabylonConstantColorEvaluator builder: builder color: aColor
]

{ #category : #drawing }
BabylonMesh2DPartBuilder >> convexHull: aCollectionOfPoints [
	^ self draw: (BabylonConvexPolygon convexHull: aCollectionOfPoints)
]

{ #category : #drawing }
BabylonMesh2DPartBuilder >> draw: aShape [
	aShape asBabylonGenericShape drawWithBuilder: self
]

{ #category : #drawing }
BabylonMesh2DPartBuilder >> drawConvexPolygon: aConvexPolygon [
	self subclassResponsibility
]

{ #category : #accessing }
BabylonMesh2DPartBuilder >> evaluator [
	^ evaluator
]

{ #category : #accessing }
BabylonMesh2DPartBuilder >> evaluator: anObject [
	evaluator := anObject
]

{ #category : #color }
BabylonMesh2DPartBuilder >> gradientStart: startPosition color: startColor end: endPosition color: endColor [
	evaluator := BabylonLinearColorGradientEvaluator new
		builder: builder;
		startPosition: startPosition endPosition: endPosition;
		startColor: startColor;
		endColor: endColor;
		yourself
]

{ #category : #accessing }
BabylonMesh2DPartBuilder >> grayTexture: aTexture [
	^ (self texture: aTexture) grayscaleTexture: true
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> grayTexture: aTexture rectangle: aRectangle [
	self
		grayTexture: aTexture;
		textureTileRectangle: aRectangle;
		rectangle: aRectangle
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> grayTextureArray: aTextureArray element: aTextureElementIndex [
	^ (self textureArray: aTextureArray element: aTextureElementIndex) grayscaleTexture: true
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> grayTextureArray: textureArray element: textureElement rectangle: aRectangle [
	self
		grayTextureArray: textureArray element: textureElement;
		textureTileRectangle: aRectangle;
		rectangle: aRectangle
]

{ #category : #color }
BabylonMesh2DPartBuilder >> horizontalGradientBounds: bounds start: startColor end: endColor [
	self gradientStart: bounds origin color: startColor
		end: bounds origin + (bounds width @ 0) color: endColor
]

{ #category : #color }
BabylonMesh2DPartBuilder >> paint: aPaint [
	aPaint applyPaintInBabylonBuilder: self
]

{ #category : #color }
BabylonMesh2DPartBuilder >> paint: aPaint tileRectangle: cellInterior [
	aPaint applyPaintInBabylonBuilder: self  tileRectangle: cellInterior
]

{ #category : #drawing }
BabylonMesh2DPartBuilder >> rectangle: aRectangle [
	^ self draw: aRectangle
]

{ #category : #drawing }
BabylonMesh2DPartBuilder >> rectangle: aRectangle round: radius [
	^ self draw: (BabylonConvexPolygon rectangle: aRectangle round: radius)
]

{ #category : #accessing }
BabylonMesh2DPartBuilder >> texture: aTexture [
	^ currentMaterial := builder driver createMaterialForTexture: aTexture
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> texture: aTexture rectangle: aRectangle [
	self
		texture: aTexture;
		textureTileRectangle: aRectangle;
		rectangle: aRectangle
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> textureArray: aTextureArray element: aTextureElementIndex [
	^ currentMaterial := builder driver createMaterialForTextureArray: aTextureArray element: aTextureElementIndex
]

{ #category : #texture }
BabylonMesh2DPartBuilder >> textureArray: textureArray element: textureElement rectangle: aRectangle [
	self
		textureArray: textureArray element: textureElement;
		textureTileRectangle: aRectangle;
		rectangle: aRectangle
]

{ #category : #color }
BabylonMesh2DPartBuilder >> textureTileRectangle: aRectangle [
	evaluator := BabylonTexcoordAffineEvaluator new builder: builder; tileRectangle: aRectangle; yourself
]

{ #category : #color }
BabylonMesh2DPartBuilder >> verticalGradientBounds: bounds start: startColor end: endColor [
	self gradientStart: bounds origin color: startColor
		end: bounds origin + (0@bounds height) color: endColor
]
