Class {
	#name : #PompeiiOpenGLCommand,
	#superclass : #PompeiiCanvas,
	#pools : [
		'UFFIOpenGLConstants'
	],
	#category : #'PompeiiGraphics-OpenGL'
}

{ #category : #execute }
PompeiiOpenGLCommand >> executeWith: gl on: surface [
]

{ #category : #testing }
PompeiiOpenGLCommand >> isDrawCommand [
	^ false
]
