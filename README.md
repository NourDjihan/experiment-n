# experiment-n

## Baselines

### Baseline for participants
Load the experiment and starts it immediately.
```Smalltalk
Metacello new
	baseline: 'Exp';
	repository: 'github://NourDjihan/experiment-n:main';
	load.
```

### Baseline for working on the Experiment framework
Doesn't start the experiment.
Just loads the experiment framework without loading the scenarios.

```Smalltalk
Metacello new
	baseline: 'ExpDev';
	repository: 'github://NourDjihan/experiment-n:main';
	load.
```
