Class {
	#name : #BaselineOfCyrusToolkit,
	#superclass : #BaselineOf,
	#category : #BaselineOfCyrusToolkit
}

{ #category : #baselines }
BaselineOfCyrusToolkit >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec blessing: #'baseline'.
		"spec project: 'BabylonGraphics' with: [
				spec
					className: #ConfigurationOfBabylonGraphics;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/BabylonGraphics/main/' ]."
		spec 
			package: #'CyrusToolkit-Core';
			package: #'CyrusToolkit-OSWindow' with: [
				spec requires: #(#'CyrusToolkit-Core' ). ];
			package: #'CyrusToolkit-Samples' with: [
				spec requires: #(#'CyrusToolkit-Core' #'CyrusToolkit-OSWindow' ). ]. ].

]
