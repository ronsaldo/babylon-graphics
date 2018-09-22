"
I represent a mesh only widget. A mesh only widget is a widget that is drawn by modifying a part a of mesh.
"
Class {
	#name : #CyTkMeshWidget,
	#superclass : #CyTkWidget,
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #changes }
CyTkMeshWidget >> changed [
	self meshChanged
]
