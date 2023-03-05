# Make sure all the packages are up to date
sudo apt-get update
sudo apt-get upgrade

# Install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda init
source ~/.bashrc

# Create environment for the programs
conda create -n supervisionWork
conda activate supervisionWork

# Install some necessary modules
conda install pip
conda install jupyter
conda install jupyterlab

# Install OCaml
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

########################## JUPYTER LAB EXTENSIONS #######################################
# Install VIM keybindings (feel free to comment out)
conda install -c conda-forge jupyterlab_vim

# Install the OCaml kernel for Jupyter Lab
sudo apt-get install -y zlib1g-dev libffi-dev libgmp-dev libzmq5-dev
opam install jupyter
grep topfind ~/.ocamlinit || echo '#use "topfind";;' >> ~/.ocamlinit  # For using '#require' directive
grep Topfind.log ~/.ocamlinit || echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit  # Suppress logging of topfind (recommended but not necessary)
ocaml-jupyter-opam-genspec
jupyter kernelspec install [ --user ] --name "ocaml-jupyter-$(opam var switch)" "$(opam var share)/jupyter"

# Add OCaml cells to Python notebooks
pip install ocaml

# Install Prolog for Jupyter Lab
pip install jswipl
cd ~/.local/share/jupyter/kernels
mkdir jswipl && cd jswipl
wget https://raw.githubusercontent.com/targodan/jupyter-swi-prolog/master/kernel.json
mkdir -p ~/Development/prolog/workspace/notebooks-001
cd ~/Development/prolog/workspace/notebook-001

# Add support for tikz graphs in jupyter notebooks
sudo apt-get update -y
sudo apt install texlive
sudo apt install imagemagick
sudo apt-get install libpoppler-dev # a dependency of pdf2svg
sudo apt-get install -y pdf2svg
pip install git+https://github.com/mkrphys/ipython-tikzmagic.git
sed -i 's/<policy domain="coder" rights="none" pattern="PDF />/<policy domain="coder" rights="read|write" pattern="PDF />/' '/etc/ImageMagick-6/policy.xml'

# Add Python code formatting
pip install jupyterlab-code-formatter
# NOTE: Install black and isort,
#       JL code formatter is configured to invoke isort and black by default
pip install black isort
