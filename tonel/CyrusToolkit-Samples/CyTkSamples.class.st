Class {
	#name : #CyTkSamples,
	#superclass : #Object,
	#category : #'CyrusToolkit-Samples'
}

{ #category : #'as yet unclassified' }
CyTkSamples class >> exampleBoxSizer [
	| window firstButton secondButton |
	window := CyTkOSWindow new.
	firstButton := CyTkButton new label: 'Hello'.
	secondButton := CyTkButton new label: 'Hello 2'.
	
	window add: firstButton;
		add: secondButton.
	window sizer: (CyTkVerticalBoxSizer new
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
CyTkSamples class >> exampleBoxSizer2 [
	| window firstButton secondButton firstButtonLabel secondButtonLabel |
	window := CyTkOSWindow new.
	firstButtonLabel := CyTkLabel new text: 'Hello'.
	firstButton := CyTkButton new label: 'Hello'.
	secondButtonLabel := CyTkLabel new text: 'Hello 2'.
	secondButton := CyTkButton new label: 'Hello 2'.
	
	window
		add: firstButtonLabel;
		add: firstButton;
		add: secondButtonLabel;
		add: secondButton.
	window sizer: (CyTkVerticalBoxSizer new
		element: (CyTkHorizontalBoxSizer new
			element: firstButtonLabel do: [ :el | el proportion: 1];
			element: firstButton do: [ :el | el proportion: 1; expand]
		) do: [ :el | el proportion: 1; expand];
		element: (CyTkHorizontalBoxSizer new
			element: secondButtonLabel do: [ :el | el proportion: 1];
			element: secondButton do: [ :el | el proportion: 1; expand]
		) do: [ :el | el proportion: 1; expand];
		yourself);
		autolayout: true;
		fit.
	window open
]

{ #category : #'as yet unclassified' }
CyTkSamples class >> exampleWindowWithButton [
	| window button |
	window := CyTkOSWindow new.
	button := CyTkButton new label: 'Hello'.
	button on: CyTkActionEvent do: [ :event |
		button label: 'Good bye'
	].

	window add: button.
	window open
]

{ #category : #'as yet unclassified' }
CyTkSamples class >> exampleWindowWithMenuBar [
	| window menuBar |
	window := CyTkOSWindow new.
	menuBar := CyTkMenuBar new.
	menuBar
		addMenuItem: 'File' menuWith: [:menu |
			menu
				addMenuItem: 'Submenu' menuWith: [ :submenu |
					submenu
						addMenuItem: 'Hello';
						addMenuItem: 'World'
					];
				addMenuSeparator;
				addMenuItem: 'Exit' action: [ :event | ]
			];
		addMenuItem: 'Help' menuWith: [:menu |
			menu
				addMenuItem: 'About' action: [ :event | ]
			];
		yourself.

	window
		add: menuBar;
		sizer: (CyTkVerticalBoxSizer new
			element: menuBar do: [ :el | el expand ];
			yourself);
		autolayout: true;
		updateLayout.
	window open
]
