Extension { #name : #Form }

{ #category : #'*BabylonGraphics-Core' }
Form >> applyPaintInBabylonBuilder: builder [
	builder texture: self
]

{ #category : #'*BabylonGraphics-Core' }
Form >> applyPaintInBabylonBuilder: builder tileRectangle: aRectangle [
	builder texture: self; textureTileRectangle: aRectangle
]
