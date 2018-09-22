Class {
	#name : #BabylonOpenGLSetModelViewCommand,
	#superclass : #BabylonOpenGLCommand,
	#instVars : [
		'matrix'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #execute }
BabylonOpenGLSetModelViewCommand >> executeWith: gl on: surface [
	surface modelViewMatrix: matrix
]

{ #category : #accessing }
BabylonOpenGLSetModelViewCommand >> matrix [
	^ matrix
]

{ #category : #accessing }
BabylonOpenGLSetModelViewCommand >> matrix: anObject [
	matrix := anObject
]
