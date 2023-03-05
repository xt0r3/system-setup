# Make sure all the packages are up to date
yes "yes" | sudo add-apt-repository ppa:swi-prolog/stable  # Add Prolog repository
sudo apt-get update
sudo apt-get upgrade

# Install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.1.0-1-Linux-x86_64.sh
bash Miniconda3-py38_23.1.0-1-Linux-x86_64.sh
rm Miniconda3-py38_23.1.0-1-Linux-x86_64.sh
source ~/.bashrc
conda init
source ~/.bashrc

# Create environment for the programs
conda create -n supervisionWork python=3.8.16
CONDA_PATH="$(conda info | grep -i 'base environment' | sed 's/[^\/]*\([^ ]*\).*/\1/')"
source "$CONDA_PATH/etc/profile.d/conda.sh"
conda activate supervisionWork 

# Install some necessary modules
yes | conda install pip
yes | conda install jupyter
yes | conda install jupyterlab

# Install SWI-Prolog
yes | sudo apt-get install swi-prolog-nox=7.6.4+dfsg-2ubuntu2
yes | sudo apt-get install swi-prolog-x=7.6.4+dfsg-2ubuntu2
yes | sudo apt-get install swi-prolog=7.6.4+dfsg-2ubuntu2

# Install OCaml
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"

########################## JUPYTER LAB EXTENSIONS #######################################
# Install VIM keybindings (feel free to comment out)
yes | conda install -c conda-forge jupyterlab_vim

# Install the OCaml kernel for Jupyter Lab
yes | sudo apt-get install -y zlib1g-dev libffi-dev libgmp-dev libzmq5-dev
opam install jupyter
grep topfind ~/.ocamlinit || echo '#use "topfind";;' >> ~/.ocamlinit  # For using '#require' directive
grep Topfind.log ~/.ocamlinit || echo 'Topfind.log:=ignore;;' >> ~/.ocamlinit  # Suppress logging of topfind (recommended but not necessary)
ocaml-jupyter-opam-genspec
jupyter kernelspec install --user --name "ocaml-jupyter-$(opam var switch)" "$(opam var share)/jupyter"

# Add OCaml cells to Python notebooks
yes | pip install ocaml

# Install Prolog for Jupyter Lab
yes | pip install jswipl
cd ~/.local/share/jupyter/kernels
mkdir jswipl && cd jswipl
wget https://raw.githubusercontent.com/targodan/jupyter-swi-prolog/master/kernel.json
mkdir -p ~/Development/prolog/workspace/notebooks-001
cd ~/Development/prolog/workspace/notebook-001

# Add support for tikz graphs in jupyter notebooks
yes | sudo apt install texlive
yes | sudo apt install imagemagick
yes | sudo apt-get install libpoppler-dev # a dependency of pdf2svg
yes | sudo apt-get install pdf2svg
yes | pip install git+https://github.com/mkrphys/ipython-tikzmagic.git
sed -i 's/<policy domain="coder" rights="none" pattern="PDF />/<policy domain="coder" rights="read|write" pattern="PDF />/' '/etc/ImageMagick-6/policy.xml'

# Add Python code formatting
yes | pip install jupyterlab-code-formatter
# NOTE: Install black and isort,
#       JL code formatter is configured to invoke isort and black by default
yes | pip install black isort

echo "Successful setup. Please restart the terminal to start using the new features."

