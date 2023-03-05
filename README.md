**Requirements**: Ubuntu 20.04 LTS

Run `bash script.sh` (or `bash script-vim.sh` if you want to add vim keybindings to your environment)
After that, the example notebooks should work as intended.

# Jupyter Lab Setup
This part guides you through how the `setup.sh` script actually works and what you need to pay attention to when modifying the results. Reading it is **strongly** recommended.


Note:
Everything below assumes that you are running an Ubuntu environment (either as an OS, or in WSL) with Python (and pip) installed.


## Install OCaml
- Install OPAM from [here](https://opam.ocaml.org/doc/Install.html)
- Use the following script:
	- `$ bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"`

- Install the OCaml kernel from [here](https://akabe.github.io/ocaml-jupyter/)
## OCaml in Python cells
- [Plugin](https://blog.janestreet.com/using-python-and-ocaml-in-the-same-jupyter-notebook/) created by Jane Street
	- Run `pip install ocaml` to install it
	- Then import the module in a file by calling `import ocaml`
	- Then, for OCaml cells, use the custom magic
		```
		%%ocaml
		[OCaml code goes here]
		```

## Install VIM keybindings
- https://pypi.org/project/jupyterlab-vim/ 

## Install Tikz for graph drawings
- Install tikz
	```
	sudo apt-get update -y
	sudo apt install texlive
	sudo apt install imagemagick
	sudo apt-get install libpoppler-dev # a dependency of pdf2svg
	sudo apt-get install -y pdf2svg
	```
- Install tikz for Jupyter Lab from [here](https://github.com/mkrphys/ipython-tikzmagic)
	- Replace pip install git+git://github.com/mkrphys/ipython-tikzmagic.git
	With `pip install git+https://github.com/mkrphys/ipython-tikzmagic.git`
	- If you get the “No image was generated” error, it might be [this](https://github.com/mkrphys/ipython-tikzmagic/issues/18)

## Install Python code formatting
- [Repo link](https://github.com/ryantam626/jupyterlab_code_formatter)

## Get LaTeX macros running
- It is CRUCIAL that you don’t have any newlines in this file (the Markdown parser does not support Latex macros, but the HTML parser does. After a HTML block, the HTML parser parses the text until the next newline. This gets ruined if we leave a newline in the macro block)
	```
	<div hidden>
	\[
	\iffalse \textrm{General purpose macros} \fi
	\renewcommand{\deg}{{^{\circ}}}
	\newcommand{\rbr}[1]{{\left({{#1}}\right)}}
	\newcommand{\abr}[1]{{\left\langle{{#1}}\right\rangle}}
	\newcommand{\cbr}[1]{{\left\{{{#1}}\right\}}}
	\newcommand{\sbr}[1]{{\left[{{#1}}\right]}}
	\newcommand{\pipe}[1]{{\left|{{#1}}\right|}}
	\newcommand{\ppipe}[1]{{\left\|{{#1}}\right\|}}
	\newcommand{\floor}[1]{{\left\lfloor{{#1}}\right\rfloor}}
	\newcommand{\ceil}[1]{{\left\lceil{{#1}}\right\rceil}}
	\newcommand{\set}[1]{{ \cbr{{#1}} }}
	\newcommand{\P}{\mathbb{P}}
	\newcommand{\Q}{\mathbb{Q}}
	\newcommand{\Z}{\mathbb{Z}}
	\newcommand{\N}{\mathbb{N}}
	\newcommand{\R}{\mathbb{R}}
	\newcommand{\C}{\mathbb{C}}
	\iffalse \textrm{Semantics macros} \fi
	\newcommand{\iet}[3]{{\textrm{if } {{#1}} \textrm{ then } {{#2}} \textrm{ else } {{#3}}}}
	\renewcommand{\t}[0]{{\textrm{true}}}
	\newcommand{\f}[0]{{\textrm{false}}}
	\iffalse \textrm{Compiler Construction macros} \fi
	\newcommand{\fst}[1]{{\textrm{FIRST}({{#1}})}}
	\newcommand{\flw}[1]{{\textrm{FOLLOW}({{#1}})}}
	\newcommand{\gen}[2][]{{ {{#1}} \implies {{#2}} }} 
	\]
	</div>
	```
