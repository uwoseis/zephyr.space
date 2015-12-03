# Embedding

One of the design goals for Zephyr is to ensure that the forward-modelling architecture (viz., `zephyr.backend`) may be straightforwardly embedded in other programs. As such, an effort has been made to limit the dependencies for the backend infrastructure that handles simulating wave equations. In particular, Zephyr has been designed to interface with a new version of FULLWV, a well-known academic seismic full-waveform inversion package by Prof. R. Gerhard Pratt et al.

## FULLWV integration

