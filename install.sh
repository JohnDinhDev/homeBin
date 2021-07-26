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

SCRIPT_FILES=$(ls ./scripts/*.sh) # list of .sh files in the scripts folder
for script in $SCRIPT_FILES; do
  # Finds filename
  FILENAME_REGEX="\w+.sh"
  FILENAME=$(echo $script | grep -oP $FILENAME_REGEX)

  # removes the ".sh" extension from the end of "$FILENAME.sh"
  FILENAME=${FILENAME%.sh}

  if [ -f $HOME/bin/$FILENAME ]; then
    echo "Overwriting $script ==> $HOME/bin/$FILENAME"
  else
    echo "Copying $script ==> $HOME/bin/$FILENAME"
  fi
  cp $script $HOME/bin/$FILENAME

  chmod 750 $HOME/bin/$FILENAME
done

echo "Done. You can delete this folder now."
