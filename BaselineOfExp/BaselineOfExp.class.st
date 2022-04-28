"
Load the experiment baseline and starts it immediately.
"
Class {
	#name : #BaselineOfExp,
	#superclass : #BaselineOf,
	#category : #BaselineOfExp
}

{ #category : #baselines }
BaselineOfExp >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec postLoadDoIt: #postload:package:.
		spec package: 'XPImageGeneration' ]
]

{ #category : #baselines }
BaselineOfExp >> postload: loader package: packageSpec [

	UIManager default
		informUser: 'Generating experient image. Please wait...'
		during: [ 
		(self class environment at: #XPImageGeneration) generateImage ].
	(self class environment at: #ExperimentN) startIt
	"(self class environment at: #XPMessageBox)
		showDialog: 'Experiment image generation completed.'
		withTitle: 'Finished!'"
]
