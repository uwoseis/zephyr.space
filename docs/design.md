# Design

Zephyr is written to make heavy use of object-oriented programming techniques, including [class multiple inheritance](https://en.wikipedia.org/wiki/Multiple_inheritance). The majority of programming constructs in the Zephyr implementation are subclasses of `AttributeMapper`, which automatically handles configuring new objects based on a global `systemConfig` dictionary (i.e., a key/value store).[^metaclass]

The interrelation between different packages (i.e., sub-modules) and object classes in Zephyr is easiest to understand visually. The following graphs were designed using `pylint`'s `pyreverse` command, and can be recreated by running
```bash
make graphs
```
in the base directory of Zephyr's source code.

## Submodule structure and design goals

This graph shows the linkages between Zephyr's submodules, including which submodules depend on others. It is important to note that `zephyr.backend` is intended to be minimally dependent on non-standard external packages, to enable solvers to be [easily embedded in existing code](embedding.md). The `zephyr.middleware` layer is dependent on features in SimPEG and other libraries to enable waveform inversion.

[![](images/packages_zephyr_small.png)
Click to expand](images/packages_zephyr.svg)

The `zephyr.frontend` layer is designed to encompass user-facing features, including the [command-line interface](frontend.md).

## Class inheritance graph

This graph shows the interrelation between the object classes in Zephyr. The dependencies for `zephyr.backend` are largely internal, whereas several features of `zephyr.middleware` depend on SimPEG.

[![](images/classes_zephyr_small.png)
Click to expand](images/classes_zephyr.svg)

## Object hierarchy and `AttributeMapper`

An `AttributeMapper` subclass defines a dictionary `initMap`, which
includes keys for mappable inputs expected from the systemConfig
parameter. The class definition takes the form:

```python
class BaseModelDependent(AttributeMapper):
    '''
    AttributeMapper subclass that implements model-dependent properties,
    such as grid coordinates and free-surface conditions.
    '''
    
    initMap = {
    #   Argument        Required    Rename as ...   Store as type
        'nx':           (True,      None,           np.int64),
        'ny':           (False,     None,           np.int64),
        'nz':           (True,      None,           np.int64),
        'xorig':        (False,     '_xorig',       np.float64),
        'yorig':        (False,     '_xorig',       np.float64),
        'zorig':        (False,     '_zorig',       np.float64),
        'dx':           (False,     '_dx',          np.float64),
        'dy':           (False,     '_dx',          np.float64),
        'dz':           (False,     '_dz',          np.float64),
        'freeSurf':     (False,     '_freeSurf',    tuple),
    }

    ...
```
    
- Each value in the dictionary is a tuple, which is interpreted by
the `AttributeMapper`[^metaclass] to determine how to process the
value corresponding to the same key in `systemConfig`.

- An exception will be raised if the first element in the tuple
is set to true, but the corresponding key does not exist in the
systemConfig parameter.

- If the second element in the tuple is set to `None`, the key will be
defined in the subclass's attribute dictionary as it stands, whereas
if the second element is a string then that overrides the key.

- If the third element in the tuple is set to `None`, the input argument
will be set in the subclass dictionary unmodified; however, if the
third element is a callable then it will be applied to the element
(e.g., to allow copying and/or typecasting of inputs).

NB: Complex `numpy` arguments are handled specially: the real part of
the value is kept and the imaginary part is discarded when they are
typecast to a float.

[^metaclass]: In fact, most of the assembly of objects is handled by `zephyr.backend.meta.AMMetaClass`, which is the [metaclass](http://blog.ionelmc.ro/2015/02/09/understanding-python-metaclasses/) for `AttributeMapper` and its descendants. All of this happens before the call to `AttributeMapper.__init__`. This enables the `initMap` class attribute to be merged automatically and inherit keys from the subclass's bases.
