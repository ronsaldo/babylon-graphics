"
I represent 2D submesh. I am used for combining different graphics primitives with the pompeii graphics API.
"
Class {
	#name : #BabylonSubmesh2D,
	#superclass : #BabylonShape,
	#instVars : [
		'primitiveType',
		'indices',
		'material'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #accessing }
BabylonSubmesh2D class >> lines [
	^ #lines
]

{ #category : #accessing }
BabylonSubmesh2D class >> points [
	^ #points
]

{ #category : #accessing }
BabylonSubmesh2D class >> triangles [
	^ #triangles
]

{ #category : #converting }
BabylonSubmesh2D >> evaluateLinesWith: aPrimitiveEvaluator [
	| lineCount i1 i2 v1 v2 |
	lineCount := indices size // 2.
	1 to: lineCount do: [ :line |
		i1 := indices at: line*2 - 1.
		i2 := indices at: line*2.
		
		v1 := aPrimitiveEvaluator evaluateVertexIndex: i1.
		v2 := aPrimitiveEvaluator evaluateVertexIndex: i2.
		aPrimitiveEvaluator evaluateLineV1: v1 v2: v2
	]
]

{ #category : #'primitive evaluation' }
BabylonSubmesh2D >> evaluatePrimitivesWith: aPrimitiveEvaluator vertices: vertices [
	primitiveType == #lines ifTrue: [ ^ self evaluateLinesWith: aPrimitiveEvaluator ].
	primitiveType == #triangles ifTrue: [ ^ self evaluateTrianglesWith: aPrimitiveEvaluator ].
	self error: 'Unsupported primitive type'
]

{ #category : #converting }
BabylonSubmesh2D >> evaluateTrianglesWith: aPrimitiveEvaluator [
	| triangleCount i1 i2 i3 v1 v2 v3 sourceIndexIndex |
	triangleCount := indices size // 3.
	sourceIndexIndex := 1.
	1 to: triangleCount do: [ :triangle |
		i1 := indices at: sourceIndexIndex. sourceIndexIndex := sourceIndexIndex + 1.
		i2 := indices at: sourceIndexIndex. sourceIndexIndex := sourceIndexIndex + 1.
		i3 := indices at: sourceIndexIndex. sourceIndexIndex := sourceIndexIndex + 1.
		
		v1 := aPrimitiveEvaluator evaluateVertexIndex: i1.
		v2 := aPrimitiveEvaluator evaluateVertexIndex: i2.
		v3 := aPrimitiveEvaluator evaluateVertexIndex: i3.
		aPrimitiveEvaluator evaluateTriangleV1: v1 v2: v2 v3: v3
	]
]

{ #category : #accessing }
BabylonSubmesh2D >> indices [
	^ indices
]

{ #category : #accessing }
BabylonSubmesh2D >> indices: anObject [
	indices := anObject
]

{ #category : #accessing }
BabylonSubmesh2D >> material [
	^ material
]

{ #category : #accessing }
BabylonSubmesh2D >> material: anObject [
	material := anObject
]

{ #category : #accessing }
BabylonSubmesh2D >> primitiveType [
	^ primitiveType
]

{ #category : #accessing }
BabylonSubmesh2D >> primitiveType: anObject [
	primitiveType := anObject
]

{ #category : #converting }
BabylonSubmesh2D >> saveWavefrontOBJInto: out [
	primitiveType == #lines ifTrue: [ ^ self saveWavefrontOBJLinesInto: out  ].
	primitiveType == #triangles ifTrue: [ ^ self saveWavefrontOBJTrianglesInto: out  ].
	self error: 'Unsupported primitive type'
]

{ #category : #converting }
BabylonSubmesh2D >> saveWavefrontOBJLinesInto: out [
	| lineCount i1 i2 |
	lineCount := indices size // 2.
	1 to: lineCount do: [ :line |
		i1 := indices at: line*2 - 1.
		i2 := indices at: line*2.
		
		out nextPutAll: 'f '; print: i1 + 1; space; print: i2 + 1; lf
	]
]

{ #category : #converting }
BabylonSubmesh2D >> saveWavefrontOBJTrianglesInto: out [
	| triangleCount i1 i2 i3 |
	triangleCount := indices size // 3.
	1 to: triangleCount do: [ :triangle |
		i1 := indices at: triangle*3 - 2.
		i2 := indices at: triangle*3 - 1.
		i3 := indices at: triangle*3.
		
		out nextPutAll: 'f '; print: i1 + 1; space; print: i2 + 1; space; print: i3 + 1; lf
	]
]
