Extension { #name : #PompeiiMesh2D }

{ #category : #'*PompeiiGraphics-SoftRendering' }
PompeiiMesh2D >> drawWithSoftRenderingCanvas: aCanvas [
	^ aCanvas drawMesh2D: self
]
