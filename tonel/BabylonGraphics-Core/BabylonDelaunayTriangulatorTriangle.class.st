Class {
	#name : #BabylonDelaunayTriangulatorTriangle,
	#superclass : #Object,
	#instVars : [
		'v1',
		'v2',
		'v3',
		't1',
		't2',
		't3'
	],
	#category : #'BabylonGraphics-Core-Geometry'
}

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> findNeighborSegment: neighbor [
	t1 == neighbor ifTrue: [ ^ 1 ].
	t2 == neighbor ifTrue: [ ^ 2 ].
	t3 == neighbor ifTrue: [ ^ 3 ].
	self error: 'Not found.'
]

{ #category : #testing }
BabylonDelaunayTriangulatorTriangle >> hasVerticesWithIndices [
	^ v1 index isNotNil and: [ v2 index isNotNil and: [v3 index isNotNil] ]
]

{ #category : #testing }
BabylonDelaunayTriangulatorTriangle >> isValidTriangle [
	^ v1 isNotNil and: [ v2 isNotNil and: [ v3 isNotNil ] ]
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> neighborAtSegment: index [
	index <= 3 ifTrue: [ 
		index = 1 ifTrue: [ ^ t1 ].
		index = 2 ifTrue: [ ^ t2 ].
		index = 3 ifTrue: [ ^ t3 ].
	] ifFalse: [ 
		index = 4 ifTrue: [ ^ t1 ].
		index = 5 ifTrue: [ ^ t2 ].
		index = 6 ifTrue: [ ^ t3 ].
	].
	self errorSubscriptBounds: index
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> neighborAtSegment: index put: newNeighbor [
	index <= 3 ifTrue: [ 
		index = 1 ifTrue: [ t1 := newNeighbor. ^ self].
		index = 2 ifTrue: [ t2 := newNeighbor. ^ self ].
		index = 3 ifTrue: [ t3 := newNeighbor. ^ self ].
	] ifFalse: [ 
		index = 4 ifTrue: [ t1 := newNeighbor. ^ self ].
		index = 5 ifTrue: [ t2 := newNeighbor. ^ self ].
		index = 6 ifTrue: [ t3 := newNeighbor. ^ self ].
	].
	self errorSubscriptBounds: index
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> positions [
	^ {v1 position . v2 position . v3 position}
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> replaceNeighbor: neighbor with: newNeighbor [
	self assert: neighbor isNotNil.
	t1 == neighbor ifTrue: [ t1 := newNeighbor. ^ self ].
	t2 == neighbor ifTrue: [ t2 := newNeighbor. ^ self ].
	t3 == neighbor ifTrue: [ t3 := newNeighbor. ^ self ].
	self error: 'Neighbor not found.'
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t1 [
	^ t1
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t1: anObject [
	t1 := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t2 [
	^ t2
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t2: anObject [
	t2 := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t3 [
	^ t3
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> t3: anObject [
	t3 := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v1 [
	^ v1
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v1: anObject [
	v1 := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v2 [
	^ v2
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v2: anObject [
	v2 := anObject
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v3 [
	^ v3
]

{ #category : #accessing }
BabylonDelaunayTriangulatorTriangle >> v3: anObject [
	v3 := anObject
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> vertexAt: index [
	index <= 3 ifTrue: [ 
		index = 1 ifTrue: [ ^ v1 ].
		index = 2 ifTrue: [ ^ v2 ].
		index = 3 ifTrue: [ ^ v3 ].
	] ifFalse: [ 
		index = 4 ifTrue: [ ^ v1 ].
		index = 5 ifTrue: [ ^ v2 ].
		index = 6 ifTrue: [ ^ v3 ].
	].
	self errorSubscriptBounds: index
]

{ #category : #'as yet unclassified' }
BabylonDelaunayTriangulatorTriangle >> vertexAt: index put: newVertex [
	index <= 3 ifTrue: [ 
		index = 1 ifTrue: [ v1 := newVertex. ^ self ].
		index = 2 ifTrue: [ v2 := newVertex. ^ self ].
		index = 3 ifTrue: [ v3 := newVertex. ^ self ].
	] ifFalse: [ 
		index = 4 ifTrue: [ v1 := newVertex. ^ self ].
		index = 5 ifTrue: [ v2 := newVertex. ^ self ].
		index = 6 ifTrue: [ v3 := newVertex. ^ self ].
	].

	self errorSubscriptBounds: index
]
