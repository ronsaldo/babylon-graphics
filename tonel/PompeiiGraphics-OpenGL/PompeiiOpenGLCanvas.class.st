Class {
	#name : #PompeiiOpenGLCanvas,
	#superclass : #PompeiiCanvas,
	#instVars : [
		'surface'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #'drawing commands' }
PompeiiOpenGLCanvas >> clear: aColor [
	surface addCommand: (PompeiiOpenGLClearCommand new
		color: aColor;
		yourself)

]

{ #category : #'as yet unclassified' }
PompeiiOpenGLCanvas >> drawConvertedShape: aConvertedShape [
	^ aConvertedShape drawWithOpenGLCanvas: self
]

{ #category : #'drawing double dispatch' }
PompeiiOpenGLCanvas >> drawGLMesh2D: mesh2D [
	mesh2D submeshes do: [ :submesh |
		surface addDrawingCommandMesh: mesh2D submesh: submesh
	].

]

{ #category : #accessing }
PompeiiOpenGLCanvas >> driver [
	^ surface driver
]

{ #category : #accessing }
PompeiiOpenGLCanvas >> surface [
	^ surface
]

{ #category : #accessing }
PompeiiOpenGLCanvas >> surface: anObject [
	surface := anObject
]

{ #category : #transforming }
PompeiiOpenGLCanvas >> transform [
	^ surface transform
]
