Class {
	#name : #PompeiiOpenGLSetModelViewCommand,
	#superclass : #PompeiiOpenGLCommand,
	#instVars : [
		'matrix'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #execute }
PompeiiOpenGLSetModelViewCommand >> executeWith: gl on: surface [
	surface modelViewMatrix: matrix
]

{ #category : #accessing }
PompeiiOpenGLSetModelViewCommand >> matrix [
	^ matrix
]

{ #category : #accessing }
PompeiiOpenGLSetModelViewCommand >> matrix: anObject [
	matrix := anObject
]
