"
I am used to build a 2D mesh.
"
Class {
	#name : #PompeiiMesh2DBuilder,
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
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #adding }
PompeiiMesh2DBuilder >> addIndex: index [
	indices add: index + baseVertex
]

{ #category : #adding }
PompeiiMesh2DBuilder >> addVertex: vertex [
	vertices add: vertex
]

{ #category : #adding }
PompeiiMesh2DBuilder >> addVertex: position color: color [
	vertices add: (PompeiiMesh2DVertex new
		position: position;
		color: color;
		yourself)
]

{ #category : #adding }
PompeiiMesh2DBuilder >> addVertex: position color: color texcoord: texcoord [
	vertices add: (PompeiiMesh2DVertex new
		position: position;
		color: color;
		texcoord: texcoord;
		yourself)
]

{ #category : #'generated bindings' }
PompeiiMesh2DBuilder >> begin: shapeType [
	self begin: shapeType material: nil
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> begin: shapeType material: aMaterial [
	(currentSubmesh isNil or: [ currentSubmesh primitiveType ~~ shapeType or:
		[currentSubmesh material ~~ aMaterial ] ]) ifTrue: [
		submeshes ifNotEmpty: [ self finishLastSubMesh ].
		currentSubmesh := PompeiiSubmesh2D new primitiveType: shapeType; material: aMaterial.
		submeshes add: currentSubmesh
	].

	baseVertex := vertices size.
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> beginLines [
	self begin: #lines
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> beginLines: aMaterial [
	self begin: #lines material: aMaterial
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> beginTriangles [
	self begin: #triangles
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> beginTriangles: aMaterial [
	self begin: #triangles material: aMaterial
]

{ #category : #accessing }
PompeiiMesh2DBuilder >> driver [
	^ driver
]

{ #category : #accessing }
PompeiiMesh2DBuilder >> driver: anObject [
	driver := anObject
]

{ #category : #builders }
PompeiiMesh2DBuilder >> fill [
	^ PompeiiMesh2DFillBuilder new builder: self
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> finishLastSubMesh [
	currentSubmesh ifNil: [ ^ self ].
	currentSubmesh indices: indices asArray.
	indices removeAll.
	currentSubmesh := nil
]

{ #category : #initialization }
PompeiiMesh2DBuilder >> initialize [
	super initialize.
	baseVertex := 0.
	vertices := OrderedCollection new.
	submeshes := OrderedCollection new.
	indices := OrderedCollection new.
	transform := PompeiiAffineTransform new.
]

{ #category : #'as yet unclassified' }
PompeiiMesh2DBuilder >> mesh [
	self finishLastSubMesh.
	^ PompeiiMesh2D new
		vertices: vertices asArray;
		submeshes: submeshes asArray;
		yourself
]

{ #category : #builders }
PompeiiMesh2DBuilder >> stroke [
	^ PompeiiMesh2DStrokeBuilder new builder: self
]

{ #category : #builders }
PompeiiMesh2DBuilder >> text [
	^ PompeiiMesh2DTextBuilder new builder: self
]

{ #category : #transforms }
PompeiiMesh2DBuilder >> transform [
	^ transform
]
