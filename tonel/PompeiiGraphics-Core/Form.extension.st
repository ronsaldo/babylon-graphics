Extension { #name : #Form }

{ #category : #'*PompeiiGraphics-Core' }
Form >> applyPaintInPompeiiBuilder: builder [
	builder texture: self
]

{ #category : #'*PompeiiGraphics-Core' }
Form >> applyPaintInPompeiiBuilder: builder tileRectangle: aRectangle [
	builder texture: self; textureTileRectangle: aRectangle
]
