Class {
	#name : #BabylonTexcoordAffineEvaluator,
	#superclass : #BabylonMeshPartEvaluator,
	#instVars : [
		'transform'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #computing }
BabylonTexcoordAffineEvaluator >> computeColor: aPosition [
	^ Color white
]

{ #category : #computing }
BabylonTexcoordAffineEvaluator >> computeTexcoord: aPosition [
	^ transform transform: aPosition
]

{ #category : #initialization }
BabylonTexcoordAffineEvaluator >> initialize [
	super initialize.
	transform := BabylonAffineTransform new.
]

{ #category : #accessing }
BabylonTexcoordAffineEvaluator >> tileRectangle: aRectangle [
	transform translateBy: aRectangle origin negated;
		scaleX: aRectangle width reciprocal Y: aRectangle height reciprocal
]

{ #category : #accessing }
BabylonTexcoordAffineEvaluator >> transform [
	^ transform
]

{ #category : #accessing }
BabylonTexcoordAffineEvaluator >> transform: anObject [
	transform := anObject
]
