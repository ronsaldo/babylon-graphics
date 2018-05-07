Class {
	#name : #BaselineOfVesuviusToolkit,
	#superclass : #BaselineOf,
	#category : #BaselineOfVesuviusToolkit
}

{ #category : #baselines }
BaselineOfVesuviusToolkit >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec blessing: #'baseline'.
		"spec project: 'PompeiiGraphics' with: [
				spec
					className: #ConfigurationOfPompeiiGraphics;
					versionString: #'bleedingEdge';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/PompeiiGraphics/main/' ]."
		spec 
			package: #'VesuviusToolkit-Core';
			package: #'VesuviusToolkit-OSWindow' with: [
				spec requires: #(#'VesuviusToolkit-Core' ). ];
			package: #'VesuviusToolkit-Samples' with: [
				spec requires: #(#'VesuviusToolkit-Core' #'VesuviusToolkit-OSWindow' ). ]. ].

]
