"
I represent a mesh only widget. A mesh only widget is a widget that is drawn by modifying a part a of mesh.
"
Class {
	#name : #VsTkMeshWidget,
	#superclass : #VsTkWidget,
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #changes }
VsTkMeshWidget >> changed [
	self meshChanged
]
