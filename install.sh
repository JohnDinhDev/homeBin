#! /bin/bash

# Create /home/$USER/bin folder if it doesn't exist
if [ ! -d $HOME/bin ]; then
  mkdir -p $HOME/bin
fi

# Add /home/$USER/bin to $PATH if it is not there
if [[ $PATH != *"$HOME/bin"* ]]
then
  export PATH=$HOME/bin:/usr/local/bin:$PATH
fi

copy_sh_file () {
  FILE_PATH=$1
  IS_SCRIPT_FILE=false

  # Finds filename
  FILENAME=$(basename $FILE_PATH)

  if [[ $FILENAME == *".sh"* ]]; then
    IS_SCRIPT_FILE=true
  fi

  # removes the ".sh" extension from the end of "$FILENAME.sh"
  FILENAME=${FILENAME%.sh}

  if [ -f $HOME/bin/$FILENAME ]; then
    echo "Overwriting $FILE_PATH ==> $HOME/bin/$FILENAME"
  else
    echo "Copying $FILE_PATH ==> $HOME/bin/$FILENAME"
  fi

  cp "$FILE_PATH" "$HOME/bin/$FILENAME"

  if $IS_SCRIPT_FILE; then
    chmod 750 $HOME/bin/$FILENAME
  fi
}

copy_files () {
  INPUT_DIR=$1
  LS_RESULTS=$(ls ${INPUT_DIR}) # list of allfiles in the scripts folder
  for path in $LS_RESULTS; do
    if [[ -f $INPUT_DIR$path ]]; then
      copy_sh_file "$INPUT_DIR$path"
    else
      copy_files "$INPUT_DIR$path/"
    fi
  done
}

copy_files "./scripts/"


echo "Done. You can delete this folder now."
