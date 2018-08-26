Class {
	#name : #VsTkToolBar,
	#superclass : #VsTkBarWidget,
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkToolBar >> buildMeshContentOn: meshBuilder [
	self theme buildToolBar: self meshOn: meshBuilder.
]

{ #category : #accessing }
VsTkToolBar >> minimalExtent [
	^ self theme computeToolBarMinimalExtent: self
]
