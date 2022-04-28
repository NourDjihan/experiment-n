# experiment-n

Baseline for participants: Load the experiment and starts it immediately:

```Smalltalk
Metacello new
	baseline: 'Exp';
	repository: 'github://NourDjihan/experiment-n:main';
	load.
```

Baseline for working on the framework: Doesn't start the exeperiment. Loads the experiment framework without loading the scenarios.

```Smalltalk
Metacello new
	baseline: 'ExpDev';
	repository: 'github://NourDjihan/experiment-n:main';
	load.
```
