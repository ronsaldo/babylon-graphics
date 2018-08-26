Class {
	#name : #VsTkMenuBar,
	#superclass : #VsTkBarWidget,
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkMenuBar >> buildMeshContentOn: meshBuilder [
	self theme buildMenuBar: self meshOn: meshBuilder.
]

{ #category : #accessing }
VsTkMenuBar >> minimalExtent [
	^ self theme computeMenuBarMinimalExtent: self
]
