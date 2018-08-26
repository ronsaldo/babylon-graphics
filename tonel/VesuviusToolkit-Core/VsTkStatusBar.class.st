Class {
	#name : #VsTkStatusBar,
	#superclass : #VsTkBarWidget,
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkStatusBar >> buildMeshContentOn: meshBuilder [
	self theme buildStatusBar: self meshOn: meshBuilder.
]

{ #category : #accessing }
VsTkStatusBar >> minimalExtent [
	^ self theme computeStatusBarMinimalExtent: self
]
