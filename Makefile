all: build

build: api 
	mkdocs build --clean

serve: build
	mkdocs serve

install: deploy

commit: api
	git add .
	git commit

deploy: commit
	mkdocs gh-deploy

api:
	sphinx-apidoc -o sphinx `python -c "import zephyr, os; print(os.path.split(zephyr.__file__)[0])"`
	$(MAKE) -C sphinx html

clean:
	rm -rf sphinx/*.rst
	rm -rf docs/api
