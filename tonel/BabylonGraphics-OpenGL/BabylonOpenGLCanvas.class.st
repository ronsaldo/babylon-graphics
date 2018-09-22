Class {
	#name : #BabylonOpenGLCanvas,
	#superclass : #BabylonCanvas,
	#instVars : [
		'surface'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #'drawing commands' }
BabylonOpenGLCanvas >> clear: aColor [
	surface addCommand: (BabylonOpenGLClearCommand new
		color: aColor;
		yourself)

]

{ #category : #'as yet unclassified' }
BabylonOpenGLCanvas >> drawConvertedShape: aConvertedShape [
	^ aConvertedShape drawWithOpenGLCanvas: self
]

{ #category : #'drawing double dispatch' }
BabylonOpenGLCanvas >> drawGLMesh2D: mesh2D [
	mesh2D submeshes do: [ :submesh |
		surface addDrawingCommandMesh: mesh2D submesh: submesh
	].

]

{ #category : #accessing }
BabylonOpenGLCanvas >> driver [
	^ surface driver
]

{ #category : #accessing }
BabylonOpenGLCanvas >> surface [
	^ surface
]

{ #category : #accessing }
BabylonOpenGLCanvas >> surface: anObject [
	surface := anObject
]

{ #category : #transforming }
BabylonOpenGLCanvas >> transform [
	^ surface transform
]
