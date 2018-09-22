"
I am used to build a 2D mesh.
"
Class {
	#name : #BabylonMesh2DBuilder,
	#superclass : #Object,
	#instVars : [
		'baseVertex',
		'vertices',
		'submeshes',
		'indices',
		'currentSubmesh',
		'transform',
		'driver'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #adding }
BabylonMesh2DBuilder >> addIndex: index [
	indices add: index + baseVertex
]

{ #category : #adding }
BabylonMesh2DBuilder >> addVertex: vertex [
	vertices add: vertex
]

{ #category : #adding }
BabylonMesh2DBuilder >> addVertex: position color: color [
	vertices add: (BabylonMesh2DVertex new
		position: position;
		color: color;
		yourself)
]

{ #category : #adding }
BabylonMesh2DBuilder >> addVertex: position color: color texcoord: texcoord [
	vertices add: (BabylonMesh2DVertex new
		position: position;
		color: color;
		texcoord: texcoord;
		yourself)
]

{ #category : #'generated bindings' }
BabylonMesh2DBuilder >> begin: shapeType [
	self begin: shapeType material: nil
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> begin: shapeType material: aMaterial [
	(currentSubmesh isNil or: [ currentSubmesh primitiveType ~~ shapeType or:
		[currentSubmesh material ~~ aMaterial ] ]) ifTrue: [
		submeshes ifNotEmpty: [ self finishLastSubMesh ].
		currentSubmesh := BabylonSubmesh2D new primitiveType: shapeType; material: aMaterial.
		submeshes add: currentSubmesh
	].

	baseVertex := vertices size.
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> beginLines [
	self begin: #lines
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> beginLines: aMaterial [
	self begin: #lines material: aMaterial
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> beginTriangles [
	self begin: #triangles
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> beginTriangles: aMaterial [
	self begin: #triangles material: aMaterial
]

{ #category : #accessing }
BabylonMesh2DBuilder >> driver [
	^ driver
]

{ #category : #accessing }
BabylonMesh2DBuilder >> driver: anObject [
	driver := anObject
]

{ #category : #builders }
BabylonMesh2DBuilder >> fill [
	^ BabylonMesh2DFillBuilder new builder: self
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> finishLastSubMesh [
	currentSubmesh ifNil: [ ^ self ].
	currentSubmesh indices: indices asArray.
	indices removeAll.
	currentSubmesh := nil
]

{ #category : #initialization }
BabylonMesh2DBuilder >> initialize [
	super initialize.
	baseVertex := 0.
	vertices := OrderedCollection new.
	submeshes := OrderedCollection new.
	indices := OrderedCollection new.
	transform := BabylonAffineTransform new.
]

{ #category : #'as yet unclassified' }
BabylonMesh2DBuilder >> mesh [
	self finishLastSubMesh.
	^ BabylonMesh2D new
		vertices: vertices asArray;
		submeshes: submeshes asArray;
		yourself
]

{ #category : #builders }
BabylonMesh2DBuilder >> stroke [
	^ BabylonMesh2DStrokeBuilder new builder: self
]

{ #category : #builders }
BabylonMesh2DBuilder >> text [
	^ PompeiiMesh2DTextBuilder new builder: self
]

{ #category : #transforms }
BabylonMesh2DBuilder >> transform [
	^ transform
]
