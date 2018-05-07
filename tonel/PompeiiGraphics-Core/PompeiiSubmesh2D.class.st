"
I represent 2D submesh. I am used for combining different graphics primitives with the pompeii graphics API.
"
Class {
	#name : #PompeiiSubmesh2D,
	#superclass : #PompeiiShape,
	#instVars : [
		'primitiveType',
		'indices',
		'material'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #accessing }
PompeiiSubmesh2D class >> lines [
	^ #lines
]

{ #category : #accessing }
PompeiiSubmesh2D class >> points [
	^ #points
]

{ #category : #accessing }
PompeiiSubmesh2D class >> triangles [
	^ #triangles
]

{ #category : #accessing }
PompeiiSubmesh2D >> indices [
	^ indices
]

{ #category : #accessing }
PompeiiSubmesh2D >> indices: anObject [
	indices := anObject
]

{ #category : #accessing }
PompeiiSubmesh2D >> material [
	^ material
]

{ #category : #accessing }
PompeiiSubmesh2D >> material: anObject [
	material := anObject
]

{ #category : #accessing }
PompeiiSubmesh2D >> primitiveType [
	^ primitiveType
]

{ #category : #accessing }
PompeiiSubmesh2D >> primitiveType: anObject [
	primitiveType := anObject
]

{ #category : #converting }
PompeiiSubmesh2D >> saveWavefrontOBJInto: out [
	primitiveType == #lines ifTrue: [ ^ self saveWavefrontOBJLinesInto: out  ].
	primitiveType == #triangles ifTrue: [ ^ self saveWavefrontOBJTrianglesInto: out  ].
	self error: 'Unsupported primitive type'
]

{ #category : #converting }
PompeiiSubmesh2D >> saveWavefrontOBJLinesInto: out [
	| lineCount i1 i2 |
	lineCount := indices size // 2.
	1 to: lineCount do: [ :line |
		i1 := indices at: line*2 - 1.
		i2 := indices at: line*2.
		
		out nextPutAll: 'f '; print: i1 + 1; space; print: i2 + 1; lf
	]
]

{ #category : #converting }
PompeiiSubmesh2D >> saveWavefrontOBJTrianglesInto: out [
	| triangleCount i1 i2 i3 |
	triangleCount := indices size // 3.
	1 to: triangleCount do: [ :triangle |
		i1 := indices at: triangle*3 - 2.
		i2 := indices at: triangle*3 - 1.
		i3 := indices at: triangle*3.
		
		out nextPutAll: 'f '; print: i1 + 1; space; print: i2 + 1; space; print: i3 + 1; lf
	]
]
