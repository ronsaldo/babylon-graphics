"
I represent a transform that it is usually implemented as 3x3 matrix.
"
Class {
	#name : #PompeiiTransform,
	#superclass : #Object,
	#category : #'PompeiiGraphics-Core'
}

{ #category : #accessing }
PompeiiTransform >> getMatrix [
	"Answer an affine transformation matrix currently used by receiver.
	Note, that resulting matrix should be copied from receiver's data, i.e.
	no future modifications of receiver should affect the answered object.
	
	The default implementation is to answer a copy of receiver"
	
	^ self copy
]

{ #category : #transformations }
PompeiiTransform >> invert [
	"i should invert"
	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> loadAffineTransform: aPompeiiTransform [
	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> loadIdentity [
	"load the identity matrix into receiver"
	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> restoreAfter: aBlock [
	"i should save the current transform state, evaluate the block, and then restore the saved transform state"
	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> rotateByDegrees: angle [

	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> scaleBy: factor [

	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> scaleX: fx Y: fy [

	self subclassResponsibility
]

{ #category : #'vector-transform' }
PompeiiTransform >> transform: aPoint [ 
	self subclassResponsibility
]

{ #category : #'vector-transform' }
PompeiiTransform >> transformX: px Y: py [ 
	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> translateBy: aPoint [

	self subclassResponsibility
]

{ #category : #transformations }
PompeiiTransform >> translateX: px Y: py [

	self subclassResponsibility
]
