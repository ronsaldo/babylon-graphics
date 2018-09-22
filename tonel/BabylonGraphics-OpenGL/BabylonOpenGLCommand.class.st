Class {
	#name : #BabylonOpenGLCommand,
	#superclass : #BabylonCanvas,
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #execute }
BabylonOpenGLCommand >> executeWith: gl on: surface [
]

{ #category : #testing }
BabylonOpenGLCommand >> isDrawCommand [
	^ false
]
