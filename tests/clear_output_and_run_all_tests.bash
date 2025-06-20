#!/bin/bash

SCRIPTDIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPTDIR"

rm -rf "./output"
mkdir -p "./output"

find "./input/" -type f -name '*.pdb' \
| ../vorochipmunk \
  --input _list \
  --processors 4 \
| column -t \
> "./output/all_global_scores.txt"

find "./input/" -type f -name '*.pdb' \
| ../vorochipmunk \
  --input _list \
  --processors 4 \
  --detailed \
  --output-table-file "./output/all_global_scores_detailed.txt"

find "./output/" -type f -name '*global_scores*' \
| grep -v "_detailed" \
| sort \
| while read -r RESULTFILE
do
	echo "$RESULTFILE"
	cat "$RESULTFILE" | sed 's/^/    /'
	echo
done

