Class {
	#name : #PompeiiOpenGLClearCommand,
	#superclass : #PompeiiOpenGLCommand,
	#instVars : [
		'color'
	],
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #accessing }
PompeiiOpenGLClearCommand >> color [
	^ color
]

{ #category : #accessing }
PompeiiOpenGLClearCommand >> color: anObject [
	color := anObject
]

{ #category : #execute }
PompeiiOpenGLClearCommand >> executeWith: gl on: surface [
	gl
		clearColor_red: color red green: color green blue: color blue alpha: color alpha;
		clear: GL_COLOR_BUFFER_BIT
]
