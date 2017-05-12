# Build conda package

    conda-build oommfc


# Upload packages to joommf channel

The change directory into the place [1] where the conda packages have
been created, and run

    anaconda upload --user joommf *.tar.bz2



[1] On OSX, this is something like `/Users/fangohr/anaconda3/conda-bld/osx-64/`.


# Which version?

- OOMMF will be compiled from github.com/fangohr/oommf (at least for
  Linux and OSX)

- Other packages will be taken from PyPI
