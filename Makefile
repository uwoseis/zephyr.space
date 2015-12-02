.PHONY: all build serve install deploy api clean

all: build

build: api 
	mkdocs build

serve: build
	mkdocs serve

install: deploy

deploy: build
	mkdocs gh-deploy
	git push github gh-pages -f

api:
	sphinx-apidoc -o sphinx `python -c "import zephyr, os; print(os.path.split(zephyr.__file__)[0])"`
	$(MAKE) -C sphinx html
	rm -rf site/api
	cp -r sphinx/build/html site/api

clean:
	rm -rf sphinx/*.rst
	rm -rf site/api
