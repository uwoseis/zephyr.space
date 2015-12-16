# Frontend / User Interface

The Zephyr project aims to fulfill two main goals:

1. To support interactive research computing and designing new algorithms, with a focus on seismic waveform inversion, and
2. to provide a flexible interface to run waveform inversion computations on parallel computing environments.

Furthermore, Zephyr makes use of distributed computing tools from IPython, which are leveraged in both operating modes. IPython (and Jupyter) combine to produce the notebook interface that is quickly becoming the standard for interactive scientific computing in Python and other interpreted languages.

## Command-line interface (`zephyr.frontend.CLI`)

NB: Work in progress

In order to provide a lightweight, non-interactive batch-mode for production and cluster computations, we have implemented a command-line based frontend to Zephyr. This command-line interface presents several sub commands that control the different functions.

    Usage: zephyr [OPTIONS] COMMAND [ARGS]...

      A command-line interface for Zephyr

    Options:
      --version  Show the version and exit.
      --help     Show this message and exit.

    Commands:
      clean    Clean up project results / outputs
      init     Set up a new modelling or inversion project
      inspect  Print information about an existing project
      invert   Run an inversion project
      migrate  Run a migration
      model    Run a forward model
      pack     Collect configuration into an HDF5 datafile
      unpack   Extract configuration from an HDF5 datafile

### zephyr clean

*Clean up project results / outputs*

Remove output files from the working directory and prepare to restart / relaunch the one of the commands `invert`, `migrate` or `model`. The `clean` command will always prompt with a list of files to delete.

### zephyr init

*Set up a new modelling or inversion project*

Generate the required files to run `invert`, `migrate` or `model`. These files and configurations may then be modified to configure the inversion.

### zephyr inspect

*Print information about an existing project*

Generate a report including a basic or extended summary of the project.

### zephyr invert

*Perform waveform inversion*

Carry out waveform inversion using the configuration files present in the current working directory. Configuration will be read from an HDF5 file matching the project name if it exists, but files present in the working directory augment and override entries in the project HDF5 file.

### zephyr migrate

*Perform reverse-time migration*

Carry out reverse-time migration using the configuration files present in the current working directory. Configuration will be read from an HDF5 file matching the project name if it exists, but files present in the working directory augment and override entries in the project HDF5 file.

### zephyr model

*Perform forward modelling*

Carry out forward modelling using the configuration files present in the current working directory. Configuration will be read from an HDF5 file matching the project name if it exists, but files present in the working directory augment and override entries in the project HDF5 file.

### zephyr pack

*Pack up configuration and data*

Take existing configuration files, data and models in the working directory, and combine them into a project HDF5 file.

### zephyr unpack

*Unpack configuration and data*

Unpack configuration items, data and models into the working directory, from a project HDF5 file.
