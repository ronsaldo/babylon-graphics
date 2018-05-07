Extension { #name : #PompeiiMesh2DVertex }

{ #category : #'*PompeiiGraphics-OpenGL' }
PompeiiMesh2DVertex >> putIntoOpenGLGrowableBuffer: aBuffer [
	aBuffer putPoint2F: position; putPoint2F: texcoord; putColor4FSRGB: color
]
