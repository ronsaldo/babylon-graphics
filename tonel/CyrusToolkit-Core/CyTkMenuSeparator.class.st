Class {
	#name : #CyTkMenuSeparator,
	#superclass : #CyTkMeshWidget,
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkMenuSeparator >> buildMeshContentOn: meshBuilder [
	self theme buildMenuSeparator: self meshOn: meshBuilder.
]

{ #category : #accessing }
CyTkMenuSeparator >> minimalExtent [
	^ self theme computeMenuSeparatorMinimalExtent: self
]
