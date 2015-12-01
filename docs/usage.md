# Usage

The zephyr project aims to fulfill two main goals:

1. To support interactive research computing and designing new algorithms, with a focus on seismic waveform inversion, and
2. to provide a flexible interface to run waveform inversion computations on parallel computing environments.

Furthermore, zephyr makes use of distributed computing tools from IPython, which are leveraged in both operating modes. IPython (and Jupyter) combine to produce the notebook interface that is quickly becoming the standard for interactive scientific computing in Python and other interpreted languages.

## Command-line interface (zephyr.frontend.CLI)

NB: Work in progress

In order to provide a lightweight, non-interactive batch-mode for production and cluster computations, we have implemented `zephyr.frontend.CLI`. This command-line interface presents several sub commands that control the different functions.

```
brendan@compute:~$ zephyr                                                                                                          
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
```

