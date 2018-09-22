"
I represent a 2D mesh.
"
Class {
	#name : #BabylonMesh2D,
	#superclass : #BabylonShape,
	#instVars : [
		'vertices',
		'submeshes'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #converting }
BabylonMesh2D >> asBabylonShapeFor: aPompeiiDriver [
	^ aPompeiiDriver convertMesh2D: self
]

{ #category : #converting }
BabylonMesh2D >> asWavefrontOBJ [
	^ ByteString streamContents: [ :out |
		self saveWavefrontOBJInto: out
	]
]

{ #category : #'primitive evaluation' }
BabylonMesh2D >> evaluatePrimitivesWith: aPrimitiveEvaluator [
	aPrimitiveEvaluator withVertices: vertices do: [ 
		submeshes do: [ :submesh |
			submesh evaluatePrimitivesWith: aPrimitiveEvaluator vertices: vertices
		]
	].

]

{ #category : #converting }
BabylonMesh2D >> saveWavefrontOBJ: fileName [
	fileName asFileReference writeStreamDo: [ :out |
		out truncate.
		self saveWavefrontOBJInto: out
	]
]

{ #category : #converting }
BabylonMesh2D >> saveWavefrontOBJInto: out [
	vertices do: [ :vertex |
		vertex saveWavefrontOBJInto: out.
	].

	submeshes do: [ :submesh |
		submesh saveWavefrontOBJInto: out.
	]	

]

{ #category : #accessing }
BabylonMesh2D >> submeshes [
	^ submeshes
]

{ #category : #accessing }
BabylonMesh2D >> submeshes: anObject [
	submeshes := anObject
]

{ #category : #accessing }
BabylonMesh2D >> vertices [
	^ vertices
]

{ #category : #accessing }
BabylonMesh2D >> vertices: anObject [
	vertices := anObject
]
