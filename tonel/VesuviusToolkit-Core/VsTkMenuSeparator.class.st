Class {
	#name : #VsTkMenuSeparator,
	#superclass : #VsTkMeshWidget,
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkMenuSeparator >> buildMeshContentOn: meshBuilder [
	self theme buildMenuSeparator: self meshOn: meshBuilder.
]

{ #category : #accessing }
VsTkMenuSeparator >> minimalExtent [
	^ self theme computeMenuSeparatorMinimalExtent: self
]
