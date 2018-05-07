Class {
	#name : #VsTkSamples,
	#superclass : #Object,
	#category : #'VesuviusToolkit-Samples'
}

{ #category : #'as yet unclassified' }
VsTkSamples class >> exampleBoxSizer [
	| window firstButton secondButton |
	window := VsTkOSWindow new.
	firstButton := VsTkButton new label: 'Hello'.
	secondButton := VsTkButton new label: 'Hello 2'.
	
	window add: firstButton;
		add: secondButton.
	window sizer: (VsTkVerticalBoxSizer new
		element: firstButton do: [ :el |
			el proportion: 1;
				borderSize: 4;
				allBorders;
				expand
		];
		element: secondButton do: [ :el |
			el proportion: 1;
				borderSize: 4;
				allBorders;
				expand
		];
		yourself);
		autolayout: true;
		fit.
	window open
]

{ #category : #'as yet unclassified' }
VsTkSamples class >> exampleBoxSizer2 [
	| window firstButton secondButton firstButtonLabel secondButtonLabel |
	window := VsTkOSWindow new.
	firstButtonLabel := VsTkLabel new text: 'Hello'.
	firstButton := VsTkButton new label: 'Hello'.
	secondButtonLabel := VsTkLabel new text: 'Hello 2'.
	secondButton := VsTkButton new label: 'Hello 2'.
	
	window
		add: firstButtonLabel;
		add: firstButton;
		add: secondButtonLabel;
		add: secondButton.
	window sizer: (VsTkVerticalBoxSizer new
		element: (VsTkHorizontalBoxSizer new
			element: firstButtonLabel do: [ :el | el proportion: 1];
			element: firstButton do: [ :el | el proportion: 1; expand]
		) do: [ :el | el proportion: 1; expand];
		element: (VsTkHorizontalBoxSizer new
			element: secondButtonLabel do: [ :el | el proportion: 1];
			element: secondButton do: [ :el | el proportion: 1; expand]
		) do: [ :el | el proportion: 1; expand];
		yourself);
		autolayout: true;
		fit.
	window open
]

{ #category : #'as yet unclassified' }
VsTkSamples class >> exampleWindowWithButton [
	| window button |
	window := VsTkOSWindow new.
	button := VsTkButton new label: 'Hello'.
	button on: VsTkActionEvent do: [ :event |
		button label: 'Good bye'
	].

	window add: button.
	window open
]
