# Intro

Welcome to the documentation and development site for Zephyr: an open-source seismic full-waveform inversion toolkit. Zephyr is designed to offer a convenient, easy-to-use set of tools and components that enable seismic FWI. Most importantly, Zephyr is free and open-source, so you can use it for your own projects and/or contribute to its development. Zephyr continues to gain features and improve daily.

[Automatically-generated API documentation][API]

## Download

To download the source code for the Zephyr project, please visit the [project page on GitHub](https://github.com/uwoseis/zephyr).

## Branches

[master][]
:   The current main branch of development for the Zephyr project.

[ani_testing][]
:   Ongoing work testing anisotropic modelling code

[distributor][]
:   Ongoing work on distributed computing schedulers for composite problems.

[disctests][]
:   Ongoing work to write tests for the discretizations.

[inversion][]
:   Ongoing work to implement a full-featured waveform inversion workflow

[oldzephyr_simpeg-integration][]
:   Development from 2014 and early 2015, which is still being laboriously merged into [master][]. This includes some of the more advanced work on distributed computing, which is gradually being included in `zephyr.middleware.distributors`.

## Dependencies

Zephyr is written in Python, and tested using the CPython implementation on Mac OS and Linux (at present the authors know of no reason that it wouldn't work on Windows, but this is untested).

Zephyr makes extensive use of [NumPy][] and [SciPy][] in order to support numerical operations. At present (and by design), `zephyr.backend` depends only on NumPy, SciPy and the Python standard library.

The `frontend` and `middleware` layers of Zephyr depend on [IPython][] for some of the parallel computing functionality.

The `frontend` and `middleware` layers of Zephyr depend on [SimPEG][], which is a flexible toolkit for solving geophysical inversion problems, written in Python. Visit the [SimPEG GitHub page](https://github.com/simpeg/simpeg) to download the project, or install with pip.

The `frontend` command-line interface depends on [Click][].

Zephyr aims to be compatible with [MUMPS][], and a corresponding Python-based wrapper called [pymatsolver][], but this functionality is experimental.

Plotting and analysis tools make use of [matplotlib][].

{!common.md!}