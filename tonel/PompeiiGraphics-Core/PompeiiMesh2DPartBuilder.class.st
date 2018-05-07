"
I am used to build a part of a 2D mesh.
"
Class {
	#name : #PompeiiMesh2DPartBuilder,
	#superclass : #Object,
	#instVars : [
		'builder',
		'evaluator'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #accessing }
PompeiiMesh2DPartBuilder >> builder [
	^ builder
]

{ #category : #accessing }
PompeiiMesh2DPartBuilder >> builder: anObject [
	builder := anObject.
	self color: Color black.
]

{ #category : #color }
PompeiiMesh2DPartBuilder >> color: aColor [
	evaluator := PompeiiConstantColorEvaluator builder: builder color: aColor
]

{ #category : #drawing }
PompeiiMesh2DPartBuilder >> convexHull: aCollectionOfPoints [
	^ self draw: (PompeiiConvexPolygon convexHull: aCollectionOfPoints)
]

{ #category : #drawing }
PompeiiMesh2DPartBuilder >> draw: aShape [
	aShape asPompeiiGenericShape drawWithBuilder: self
]

{ #category : #drawing }
PompeiiMesh2DPartBuilder >> drawConvexPolygon: aConvexPolygon [
	self subclassResponsibility
]

{ #category : #accessing }
PompeiiMesh2DPartBuilder >> evaluator [
	^ evaluator
]

{ #category : #accessing }
PompeiiMesh2DPartBuilder >> evaluator: anObject [
	evaluator := anObject
]

{ #category : #color }
PompeiiMesh2DPartBuilder >> gradientStart: startPosition color: startColor end: endPosition color: endColor [
	evaluator := PompeiiLinearColorGradientEvaluator new
		builder: builder;
		startPosition: startPosition endPosition: endPosition;
		startColor: startColor;
		endColor: endColor;
		yourself
]

{ #category : #color }
PompeiiMesh2DPartBuilder >> horizontalGradientBounds: bounds start: startColor end: endColor [
	self gradientStart: bounds origin color: startColor
		end: bounds origin + (bounds width @ 0) color: endColor
]

{ #category : #drawing }
PompeiiMesh2DPartBuilder >> rectangle: aRectangle [
	^ self draw: aRectangle
]

{ #category : #drawing }
PompeiiMesh2DPartBuilder >> rectangle: aRectangle round: radius [
	^ self draw: (PompeiiConvexPolygon rectangle: aRectangle round: radius)
]

{ #category : #color }
PompeiiMesh2DPartBuilder >> verticalGradientBounds: bounds start: startColor end: endColor [
	self gradientStart: bounds origin color: startColor
		end: bounds origin + (0@bounds height) color: endColor
]
