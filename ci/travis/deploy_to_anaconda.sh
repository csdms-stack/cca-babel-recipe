#! /bin/bash

if [ "$CONDA_RECIPES" != "runtime" ]; then
  cd conda-recipes

  CONDA_FILES_TO_UPLOAD=$(conda build --output --python=$TRAVIS_PYTHON_VERSION --numpy=$NUMPY_VERSION $CONDA_RECIPES)

  if [ "$(anaconda whoami)" == "Anonymous User" ]; then
    anaconda login --username=$CONDA_USERNAME --password=$CONDA_PASSWORD
  fi

  echo Deploying $CONDA_FILES_TO_UPLOAD to $CONDA_USERNAME
  anaconda upload --force --user csdms --channel dev $CONDA_FILES_TO_UPLOAD
fi
