Class {
	#name : #VsTkPanelWidget,
	#superclass : #VsTkContainerWidget,
	#instVars : [
		'backgroundColor'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #accessing }
VsTkPanelWidget >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
VsTkPanelWidget >> backgroundColor: anObject [
	backgroundColor := anObject
]

{ #category : #drawing }
VsTkPanelWidget >> buildMeshContentOn: meshBuilder [
	meshBuilder fill
		color: backgroundColor;
		rectangle: self localBounds
]

{ #category : #initialization }
VsTkPanelWidget >> initialize [
	super initialize.
	backgroundColor := Color transparent.
]
