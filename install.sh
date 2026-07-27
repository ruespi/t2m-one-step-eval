#!/bin/bash

set -e

if ! command -v uv &> /dev/null; then 
    echo "uv is required for setting up this repo."
    exit 1
fi

BASE_PATH=$(realpath .)

echo "Creating symlinks..."
mkdir data weights

cd MeanAudio
rm -rf data
ln -s ../data data
ln -s ../weights weights
ln -s ../av-benchmark av-benchmark

echo "Downloading weights..."
cd $BASE_PATH/weights
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/fluxaudio_s_full.pth
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/meanaudio_s_full.pth
wget https://huggingface.co/lukewys/laion_clap/resolve/main/music_speech_audioset_epoch_15_esc_89.98.pt
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/synchformer_state_dict.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/v1-16.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/v1-44.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/best_netG.pt

