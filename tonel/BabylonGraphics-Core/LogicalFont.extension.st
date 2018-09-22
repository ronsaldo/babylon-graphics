Extension { #name : #LogicalFont }

{ #category : #'*BabylonGraphics-Core' }
LogicalFont >> forBabylonDriver: aBabylonDriver [
	^ aBabylonDriver font: self
]
