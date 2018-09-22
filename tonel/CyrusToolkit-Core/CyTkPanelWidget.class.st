Class {
	#name : #CyTkPanelWidget,
	#superclass : #CyTkContainerWidget,
	#instVars : [
		'backgroundColor'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #accessing }
CyTkPanelWidget >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
CyTkPanelWidget >> backgroundColor: anObject [
	backgroundColor := anObject
]

{ #category : #drawing }
CyTkPanelWidget >> buildMeshContentOn: meshBuilder [
	meshBuilder fill
		color: backgroundColor;
		rectangle: self localBounds
]

{ #category : #initialization }
CyTkPanelWidget >> initialize [
	super initialize.
	backgroundColor := Color transparent.
]
