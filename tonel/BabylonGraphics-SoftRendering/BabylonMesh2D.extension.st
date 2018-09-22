Extension { #name : #BabylonMesh2D }

{ #category : #'*BabylonGraphics-SoftRendering' }
BabylonMesh2D >> drawWithSoftRenderingCanvas: aCanvas [
	^ aCanvas drawMesh2D: self
]
