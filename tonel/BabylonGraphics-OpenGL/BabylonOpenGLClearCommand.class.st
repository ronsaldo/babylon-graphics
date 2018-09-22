Class {
	#name : #BabylonOpenGLClearCommand,
	#superclass : #BabylonOpenGLCommand,
	#instVars : [
		'color'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'BabylonGraphics-OpenGL'
}

{ #category : #accessing }
BabylonOpenGLClearCommand >> color [
	^ color
]

{ #category : #accessing }
BabylonOpenGLClearCommand >> color: anObject [
	color := anObject
]

{ #category : #execute }
BabylonOpenGLClearCommand >> executeWith: gl on: surface [
	gl
		clearColor_red: color red green: color green blue: color blue alpha: color alpha;
		clear: GL_COLOR_BUFFER_BIT
]
