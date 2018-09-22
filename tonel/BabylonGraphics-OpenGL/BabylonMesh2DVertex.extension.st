Extension { #name : #BabylonMesh2DVertex }

{ #category : #'*BabylonGraphics-OpenGL' }
BabylonMesh2DVertex >> putIntoOpenGLGrowableBuffer: aBuffer [
	aBuffer putPoint2F: position; putPoint2F: texcoord; putColor4FSRGB: color
]
