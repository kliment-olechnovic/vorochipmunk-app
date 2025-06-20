# About VoroChipmunk

VoroChipmunk is method to calculate area statistical pseudo-energy of interfaces in protein complexes.
VoroChipmunk uses a knowledge-based statistical potential defined for Voronoi tessellation-based contact areas.
The statisctical area-based potential was derived from ensembles of protein conformations collected from PBD,
it accounts for observed probabilities of atom-atom contact areas to occur and persist in a structural ensemble.

VoroChipmunk is developed as one of the results of the MARMOTTTE project.
The details of the method are to be published soon.
This repository provides an alpha version of VoroChipmunk app.

VoroChipmunk is developed by Kliment Olechnovic ([www.kliment.lt](https://www.kliment.lt)).

# Obtaining and setting up VoroChipmunk

## Getting the latest version

The currently recommended way to obtain VoroChipmunk is cloning the VoroChipmunk git repository [https://github.com/kliment-olechnovic/vorochipmunk-app](https://github.com/kliment-olechnovic/vorochipmunk-app):

```bash
git clone https://github.com/kliment-olechnovic/vorochipmunk-app.git
cd ./vorochipmunk-app
```

## Building the included software

VoroChipmunk comes with a statically built 'voronota-js' binary for Linux in the 'tools' subdirectory.

The source code for 'voronota-js' is also included, and can be used to build 'voronota-js' with the following command: 

```bash
./tools/build-voronota-js.bash
```

## Setting up an environment for running VoroChipmunk

VoroChipmunk does not requite any setup apart from an optional rebuilding of 'voronota-js' binary in the 'tools' subdirectory.


# Running the VoroChipmunk command-line tool

The overview of command-line options, as well as input and output, is printed when running the "vorochipmunk" executable with "--help" or "-h" flags:

```bash
vorochipmunk --help

vorochipmunk -h
```

The following is the help message output:

```

'vorochipmunk' script calculates inter-chain interfaces area statistical pseudo-energy for protein complexes.

Options:
    --input | -i                  string  *  input file path or '_list' to read file paths from stdin
    --restrict-input              string     query to restrict input atoms, default is '[]'
    --subselect-contacts          string     query to subselect inter-chain contacts, default is '[]''
    --output-table-file           string     output table file path, default is '_stdout' to print to stdout
    --processors                  number     maximum number of processors to run in parallel, default is 1
    --stdin-file                  string     input file path to replace stdin
    --run-faspr                   string     path to FASPR binary to rebuild side-chains
    --input-is-script                        flag to treat input file as vs script
    --as-assembly                            flag to treat input file as biological assembly
    --detailed                               flag to enable detailed output
    --help | -h                              flag to display help message and exit

Standard output:
    space-separated table of scores
    
Examples:

    vorochipmunk --input ./model.pdb
    
    vorochipmunk --input ./model.pdb --subselect-contacts '[-a1 [-chain A,C] -a2 [-chain D,F]]'
    
    ls *.pdb | vorochipmunk --input _list --processors 8 | column -t
    
```

# Output example

Running

```bash
find "./tests/input/" -type f -name '*.pdb' \
| ./vorochipmunk \
  --input _list \
  --processors 4 \
| column -t
```

gives

```
input_name  input_atoms  iface_area  iface_pseudoenergy  iface_clash_score
target.pdb  2095         1047.81     -88.0548            0
model2.pdb  2440         977.962     -63.64              0
model1.pdb  2720         979.896     -57.6966            0
```
