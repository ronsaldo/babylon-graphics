"
I provide an interface for handling events.
"
Trait {
	#name : #TVsTkEventHandler,
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #'events-processing' }
TVsTkEventHandler >> handleActionEvent: anEvent [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleGotFocus: anEvent [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleKeyDown: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleKeyUp: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleLostFocus: anEvent [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleMouseButtonDown: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleMouseButtonUp: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleMouseEnter: anEvent [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleMouseLeave: anEvent [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleMouseMove: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> handleTextInput: event [
]

{ #category : #'events-processing' }
TVsTkEventHandler >> processEvent: anEvent [
	anEvent handleWith: self
]
