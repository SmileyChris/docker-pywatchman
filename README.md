# Python watchman Docker Image

Django's runserver works a lot more efficiently with watchman installed.

If you are using a virtualenv in your container you'll just need to run
`pip install /pywatchman-*.whl` from within your environment.


## Building this Image

Run `make` to build the image against Python 3.7 or `make PY=3.8` to build for a
different Python version. You can also build multiple versions at the same time,
for example:

```
make PY="3.6 3.7 3.8 3.6-slim 3.7-slim 3.8-slim"
```
