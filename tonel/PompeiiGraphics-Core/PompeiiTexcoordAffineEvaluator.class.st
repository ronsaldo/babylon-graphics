Class {
	#name : #PompeiiTexcoordAffineEvaluator,
	#superclass : #PompeiiMeshPartEvaluator,
	#instVars : [
		'transform'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #computing }
PompeiiTexcoordAffineEvaluator >> computeColor: aPosition [
	^ Color white
]

{ #category : #computing }
PompeiiTexcoordAffineEvaluator >> computeTexcoord: aPosition [
	^ transform transform: aPosition
]

{ #category : #initialization }
PompeiiTexcoordAffineEvaluator >> initialize [
	super initialize.
	transform := PompeiiAffineTransform new.
]

{ #category : #accessing }
PompeiiTexcoordAffineEvaluator >> tileRectangle: aRectangle [
	transform translateBy: aRectangle origin negated + (0@1);
		scaleX: aRectangle width reciprocal Y: aRectangle height reciprocal negated
]

{ #category : #accessing }
PompeiiTexcoordAffineEvaluator >> transform [
	^ transform
]

{ #category : #accessing }
PompeiiTexcoordAffineEvaluator >> transform: anObject [
	transform := anObject
]
