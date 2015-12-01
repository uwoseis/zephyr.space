# Usage

The Zephyr project aims to fulfill two main goals:

1. To support interactive research computing and designing new algorithms, with a focus on seismic waveform inversion, and
2. to provide a flexible interface to run waveform inversion computations on parallel computing environments.

Furthermore, Zephyr makes use of distributed computing tools from IPython, which are leveraged in both operating modes. IPython (and Jupyter) combine to produce the notebook interface that is quickly becoming the standard for interactive scientific computing in Python and other interpreted languages.

## Command-line interface (`zephyr.frontend.CLI`)

NB: Work in progress

In order to provide a lightweight, non-interactive batch-mode for production and cluster computations, we have implemented a command-line based frontend to Zephyr. This command-line interface presents several sub commands that control the different functions.

```
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
```

### zephyr clean

*Clean up project results / outputs*

The purpose of the `clean` command is to remove output files from the working directory and prepare to restart / relaunch the one of the commands `invert`, `migrate` or `model`. The `clean` command will always prompt with a list of files to delete.

### zephyr init

*Set up a new modelling or inversion project*

The purpose of the `init` command is to generate the required files to run `invert`, `migrate` or `model`. These files and configurations may then be modified to configure the inversion.

### zephyr inspect

*Print information about an existing project*

