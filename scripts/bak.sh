#! /bin/bash

for arg in $@ ; do
  if [[ -f $arg ]]; then
    FILENAME=$(basename $arg)
    DEST=${arg%$FILENAME}
    cp $arg $DEST$FILENAME.bak
  elif [[ -d $arg ]]; then
    DIRNAME=$(basename $arg)
    DEST=${arg%$DIRNAME}
    DIRNAME=$DIRNAME\_bak/
    echo $DEST$DIRNAME
    cp -r $arg $DEST$DIRNAME
  fi
done


