"
I provide an interface for handling events.
"
Trait {
	#name : #TCyTkEventHandler,
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #'events-processing' }
TCyTkEventHandler >> handleActionEvent: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleClick: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleDoubleClick: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleDragEndEvent: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleDragEvent: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleDragStartEvent: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleDropEvent: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleGotFocus: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleKeyDown: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleKeyUp: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleLostFocus: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseButtonDown: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseButtonUp: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseEnter: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseLeave: anEvent [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseMove: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleMouseWheel: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> handleTextInput: event [
]

{ #category : #'events-processing' }
TCyTkEventHandler >> processEvent: anEvent [
	anEvent handleWith: self
]
