Class {
	#name : #CyTkLabel,
	#superclass : #CyTkMeshWidget,
	#instVars : [
		'text'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkLabel >> buildMeshContentOn: meshBuilder [
	self theme buildLabel: self meshOn: meshBuilder.
]

{ #category : #initialization }
CyTkLabel >> initialize [
	super initialize.
	text := ''.
]

{ #category : #accessing }
CyTkLabel >> minimalExtent [
	^ self theme computeLabelMinimalExtent: self
]

{ #category : #accessing }
CyTkLabel >> text [
	^ text
]

{ #category : #accessing }
CyTkLabel >> text: aString [
	text := aString.
	self changed.
]
