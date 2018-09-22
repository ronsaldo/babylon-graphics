Class {
	#name : #CyTkStatusBar,
	#superclass : #CyTkBarWidget,
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkStatusBar >> buildMeshContentOn: meshBuilder [
	self theme buildStatusBar: self meshOn: meshBuilder.
]

{ #category : #accessing }
CyTkStatusBar >> minimalExtent [
	^ self theme computeStatusBarMinimalExtent: self
]
