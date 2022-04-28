Class {
	#name : #BaselineOfExpDev,
	#superclass : #BaselineOf,
	#category : #BaselineOfExpDev
}

{ #category : #baselines }
BaselineOfExpDev >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec postLoadDoIt: #postload:package:.
		spec package: 'XPImageGeneration' ]
]

{ #category : #baselines }
BaselineOfExpDev >> postload: loader package: packageSpec [

	UIManager default
		informUser: 'Generating experient image for development. Please wait...'
		during: [ 
		(self class environment at: #XPImageGeneration) generateImage ].
	
]
