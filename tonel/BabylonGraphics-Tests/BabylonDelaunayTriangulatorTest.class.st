Class {
	#name : #BabylonDelaunayTriangulatorTest,
	#superclass : #TestCase,
	#category : #'BabylonGraphics-Tests'
}

{ #category : #tests }
BabylonDelaunayTriangulatorTest >> testOnePoint [
	| triangulation |
	triangulation := BabylonDelaunayTriangulation fromPoints: { 0@0 }.
	self assert: triangulation isEmpty.
]

{ #category : #tests }
BabylonDelaunayTriangulatorTest >> testThreeCollinearPoint [
	| triangulation |
	triangulation := BabylonDelaunayTriangulation fromPoints: { 0@0 . 1@1 . 2@2 }.
	self assert: triangulation isEmpty
]

{ #category : #tests }
BabylonDelaunayTriangulatorTest >> testThreePoint [
	| triangulation |
	triangulation := BabylonDelaunayTriangulation fromPoints: { 0@0 . 0@1 . 1@1 }.
	self assert: triangulation isNotEmpty.
	self assert: triangulation triangles size = 1.

	
]

{ #category : #tests }
BabylonDelaunayTriangulatorTest >> testTwoPoint [
	| triangulation |
	triangulation := BabylonDelaunayTriangulation fromPoints: { 0@0 . 0@1 }.
	self assert: triangulation isEmpty.
]
