#!/bin/bash

set -e

if ! command -v uv &> /dev/null; then 
    echo "uv is required for setting up this repo."
    exit 1
fi

BASE_PATH=$(realpath .)

echo "Checking out submodules..."
git submodule update --init --recursive

echo "Setting up sub-repos..."
mkdir -p data weights exps

cd $BASE_PATH/audiocraft
ln -s ../data data
ln -s ../exps exps
mkdir -p data/audiocraft
mkdir -p exps/audiocraft

cd $BASE_PATH/ismir2017-deepsalience
ln -s ../data data

cd $BASE_PATH/MeanAudio
rm -rf data
ln -s ../data data
ln -s ../weights weights
ln -s ../av-benchmark av-benchmark
ln -s ../exps exps
mkdir -p data/meanaudio
mkdir -p exps/meanaudio

cd $BASE_PATH/av-benchmark
ln -s ../weights weights

cd $BASE_PATH/UniFlow-Audio
ln -s ../data datadir
ln -s ../weights weights
ln -s ../exps exps
mkdir -p data/uniflow
mkdir -p exps/uniflow
./patch.sh

echo "Downloading weights..."
cd $BASE_PATH/weights
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/fluxaudio_s_full.pth
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/meanaudio_s_full.pth
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/empty_string_t5.pth
wget https://huggingface.co/AndreasXi/MeanAudio/resolve/main/empty_string_clap_c.pth
wget https://huggingface.co/lukewys/laion_clap/resolve/main/music_speech_audioset_epoch_15_esc_89.98.pt
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/synchformer_state_dict.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/v1-16.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/v1-44.pth
wget https://github.com/hkchengrex/MMAudio/releases/download/v0.1/best_netG.pt

