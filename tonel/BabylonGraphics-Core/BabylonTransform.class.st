"
I represent a transform that it is usually implemented as 3x3 matrix.
"
Class {
	#name : #BabylonTransform,
	#superclass : #Object,
	#category : #'BabylonGraphics-Core-Matrices'
}

{ #category : #accessing }
BabylonTransform >> getMatrix [
	"Answer an affine transformation matrix currently used by receiver.
	Note, that resulting matrix should be copied from receiver's data, i.e.
	no future modifications of receiver should affect the answered object.
	
	The default implementation is to answer a copy of receiver"
	
	^ self copy
]

{ #category : #transformations }
BabylonTransform >> invert [
	"i should invert"
	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> loadAffineTransform: aPompeiiTransform [
	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> loadIdentity [
	"load the identity matrix into receiver"
	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> restoreAfter: aBlock [
	"i should save the current transform state, evaluate the block, and then restore the saved transform state"
	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> rotateByDegrees: angle [

	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> scaleBy: factor [

	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> scaleX: fx Y: fy [

	self subclassResponsibility
]

{ #category : #'vector-transform' }
BabylonTransform >> transform: aPoint [ 
	self subclassResponsibility
]

{ #category : #'vector-transform' }
BabylonTransform >> transformX: px Y: py [ 
	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> translateBy: aPoint [

	self subclassResponsibility
]

{ #category : #transformations }
BabylonTransform >> translateX: px Y: py [

	self subclassResponsibility
]
