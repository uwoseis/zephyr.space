.PHONY: all build serve install deploy api clean

ZEPHYRPATH=$(shell python -c "import zephyr, os; print(os.path.split(zephyr.__file__)[0])")

all: build

build: api graph
	mkdocs build

serve: build
	mkdocs serve

install: deploy

deploy: build
	mkdocs gh-deploy
	git push github gh-pages -f

api:
	sphinx-apidoc -o sphinx $(ZEPHYRPATH) 
	$(MAKE) -C sphinx html
	rm -rf site/api
	cp -r sphinx/build/html site/api

clean:
	rm -rf site/api
	rm -rf sphinx/*.rst
	rm -rf docs/images/classes_*.png docs/images/packages_*.png

graph:
	cd docs/images && pyreverse -my -A -o png -p zephyr $(ZEPHYRPATH)/**/**.py
	cd docs/images && convert classes_zephyr.png -resize 800x800 classes_zephyr_small.png
	cd docs/images && convert packages_zephyr.png -resize 800x800 packages_zephyr_small.png
