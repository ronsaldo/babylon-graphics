Class {
	#name : #CyTkToolBar,
	#superclass : #CyTkBarWidget,
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkToolBar >> buildMeshContentOn: meshBuilder [
	self theme buildToolBar: self meshOn: meshBuilder.
]

{ #category : #accessing }
CyTkToolBar >> minimalExtent [
	^ self theme computeToolBarMinimalExtent: self
]
