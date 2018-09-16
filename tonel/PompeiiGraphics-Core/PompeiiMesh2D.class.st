"
I represent a 2D mesh.
"
Class {
	#name : #PompeiiMesh2D,
	#superclass : #PompeiiShape,
	#instVars : [
		'vertices',
		'submeshes'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #converting }
PompeiiMesh2D >> asPompeiiShapeFor: aPompeiiDriver [
	^ aPompeiiDriver convertMesh2D: self
]

{ #category : #converting }
PompeiiMesh2D >> asWavefrontOBJ [
	^ ByteString streamContents: [ :out |
		self saveWavefrontOBJInto: out
	]
]

{ #category : #'primitive evaluation' }
PompeiiMesh2D >> evaluatePrimitivesWith: aPrimitiveEvaluator [
	aPrimitiveEvaluator withVertices: vertices do: [ 
		submeshes do: [ :submesh |
			submesh evaluatePrimitivesWith: aPrimitiveEvaluator vertices: vertices
		]
	].

]

{ #category : #converting }
PompeiiMesh2D >> saveWavefrontOBJ: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate.
		self saveWavefrontOBJInto: out
	]
]

{ #category : #converting }
PompeiiMesh2D >> saveWavefrontOBJInto: out [
	vertices do: [ :vertex |
		vertex saveWavefrontOBJInto: out.
	].

	submeshes do: [ :submesh |
		submesh saveWavefrontOBJInto: out.
	]	

]

{ #category : #accessing }
PompeiiMesh2D >> submeshes [
	^ submeshes
]

{ #category : #accessing }
PompeiiMesh2D >> submeshes: anObject [
	submeshes := anObject
]

{ #category : #accessing }
PompeiiMesh2D >> vertices [
	^ vertices
]

{ #category : #accessing }
PompeiiMesh2D >> vertices: anObject [
	vertices := anObject
]
