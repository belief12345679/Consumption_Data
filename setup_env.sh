#!/bin/bash
# setup_env.sh

# 1. Detect OS and CPU Architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
    Darwin*)
        # Apple Silicon (M1, M2, M3, M4) vs Intel Mac
        if [ "${ARCH}" = "arm64" ]; then
            INSTALLER="Miniconda3-latest-MacOSX-arm64.sh"
        else
            INSTALLER="Miniconda3-latest-MacOSX-x86_64.sh"
        fi
        ;;
    Linux*)
        if [ "${ARCH}" = "x86_64" ]; then
            INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
        else
            INSTALLER="Miniconda3-latest-Linux-aarch64.sh"
        fi
        ;;
    MSYS*|MINGW*|CYGWIN*)
        INSTALLER="Miniconda3-latest-Windows-x86_64.exe"
        ;;
    *)
        echo "Unsupported OS: ${OS}"
        exit 1
        ;;
esac

# 2. Download and Execute the Installer
echo "Downloading ${INSTALLER}..."
curl -O "https://repo.anaconda.com/miniconda/${INSTALLER}"

# For macOS and Linux (shell script installers)
if [[ "${INSTALLER}" == *.sh ]]; then
    # Run in batch mode (-b) and set install path (-p)
    bash "${INSTALLER}" -b -p "$HOME/miniconda3"
    # Initialize conda for the current shell session
    source "$HOME/miniconda3/bin/activate"
    conda init bash
else
    # For Windows
    start "${INSTALLER}"
    echo "Windows installer launched. Please complete the setup manually."
    exit 0
fi

# 3. Create Virtual Environment
# -y: Assume 'yes' to all prompts
# Using conda-forge for better M4 (ARM) optimization
conda create -y -n consumption_data python=3.12 numpy pandas scipy statsmodels matplotlib seaborn ipykernel jupyterlab pip scikit-learn -c conda-forge
pip install deep_translator

echo "Setup complete."
echo "To start, run: conda activate consumption_data"
