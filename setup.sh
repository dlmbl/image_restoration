#!/bin/bash

# create environment
ENV="05_image_restoration"
conda create -y -n "$ENV" python=3.10
conda activate "$ENV"

# check that the environment was activated
if [[ "$CONDA_DEFAULT_ENV" == "$ENV" ]]; then
    echo "Environment activated successfully"
else
    echo "Failed to activate the environment"
fi

# Further instructions that should only run if the environment is active
if [[ "$CONDA_DEFAULT_ENV" == "$ENV" ]]; then
    conda install -y pytorch-gpu cuda-toolkit=11.8 torchvision -c nvidia -c conda-forge -c pytorch
    #mamba install -y pytorch torchvision pytorch-cuda=11.8 -c pytorch -c nvidia
    pip install jupytext black nbconvert albumentations ml_collections wandb scikit-learn ipykernel gdown "careamics[examples,tensorboard] @ git+https://github.com/CAREamics/careamics.git"
    # Using pytorch-lightning 2.4.0 causes bugs in tensorboard and interupting training.
    pip install pytorch-lightning==2.3.3
    pip install git+https://github.com/dlmbl/dlmbl-unet
    python -m ipykernel install --user --name "05_image_restoration"
    # Clone the extra repositories
    git clone https://github.com/krulllab/COSDD.git -b n_dimensional 03_COSDD/COSDD
    git clone https://github.com/juglab/denoiSplit.git 04_DenoiSplit/denoisplit

    # Download the data
    python download_careamics_portfolio.py
    cd data/
    wget "https://s3.ap-northeast-1.wasabisys.com/gigadb-datasets/live/pub/10.5524/100001_101000/100888/03-mito-confocal/mito-confocal-lowsnr.tif"
    mkdir CCPs/
    cd CCPs/
    gdown 16oiMkH3cpVU500MSPbm7ghOpEMoD2YNu
    cd ../
    mkdir ER/
    cd ER/
    gdown 1Bho6Oymfxi7OV0tPb9wkINkVOCpTaL7M
    cd ../
    mkdir Microtubules/
    cd Microtubules/
    gdown 14sPIEE2qU2J6oRFMz46v2IvkCVjFX8D1
    cd ../
    mkdir F-actin/
    cd F-actin/
    gdown 1FYO-Bpl5vjpiJ6kzV1qO1pL37Y3Dirfy
    cd ../../
    mkdir 03_COSDD/checkpoints
    cd 03_COSDD/checkpoints
    gdown --folder 1_oUAxagFVin71xFASb9oLF6pz20HjqTr
    cd ../../
fi


