.PHONY: all clean

all:
	rm -f ohplease.js
	ocamlbuild -use-ocamlfind -plugin-tag "package(js_of_ocaml.ocamlbuild)" ohplease.js
	cp _build/ohplease.js .

clean:
	ocamlbuild -clean
