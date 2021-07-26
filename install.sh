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
  # removes "./scripts/" from the beginning of "./scripts/$FILENAME.sh"
  FILENAME=${script#./scripts/}
  # removes the ".sh" extension from the end of "$FILENAME.sh"
  FILENAME=${FILENAME%.sh}

  cp $script $HOME/bin/$FILENAME

  chmod 750 $HOME/bin/$FILENAME
done
