#!/bin/bash

# Check if the current conda environment is "comfy"
if [ "$CONDA_DEFAULT_ENV" != "comfy" ]; then
  echo "Please create a conda environment named 'comfy' first. Run the following commands:"
  echo "conda init"
  echo "conda create -ny comfy python=3.12.7"
  echo "conda activate comfy"
  cd ~
  touch abc
  exit 1
fi

echo "The current conda environment is 'comfy'."
echo "conda activate comfy" >> ~/.bashrc
echo "conda activate comfy" >> ~/.zshrc

conda install -y vim
conda install -y sshpass

echo "Create the tunnel and start scripts."
cd ~
echo 'sshpass -p "" autossh -M 0 -R 9999:localhost:8188 -p 7777 -o ServerAliveInterval=60 -o StrictHostKeyChecking=no s@nowis.zapto.org' > tunnel
chmod +x tunnel
echo 'python ComfyUI/main.py --highvram' > start
chmod +x start

git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu124
pip install -r requirements.txt
cd custom_nodes
git clone https://github.com/ltdrdata/ComfyUI-Manager.git
cd ..
wget -O models/unet/flux1-dev-Q8_0.gguf "https://huggingface.co/city96/FLUX.1-dev-gguf/resolve/main/flux1-dev-Q8_0.gguf?download=true"
wget -O models/clip/t5-v1_1-xxl-encoder-Q8_0.gguf "https://huggingface.co/city96/t5-v1_1-xxl-encoder-gguf/resolve/main/t5-v1_1-xxl-encoder-Q8_0.gguf?download=true"
wget -O models/clip/ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors "https://huggingface.co/zer0int/CLIP-GmP-ViT-L-14/resolve/main/ViT-L-14-TEXT-detail-improved-hiT-GmP-TE-only-HF.safetensors?download=true"
mkdir -p models/xlabs/controlnets
wget -O models/xlabs/controlnets/flux-canny-controlnet-v3.safetensors "https://huggingface.co/XLabs-AI/flux-controlnet-collections/resolve/main/flux-canny-controlnet-v3.safetensors?download=true"
wget -O models/xlabs/controlnets/flux-depth-controlnet-v3.safetensors "https://huggingface.co/XLabs-AI/flux-controlnet-collections/resolve/main/flux-depth-controlnet-v3.safetensors?download=true"
wget -O models/xlabs/controlnets/flux-hed-controlnet-v3.safetensors "https://huggingface.co/XLabs-AI/flux-controlnet-collections/resolve/main/flux-hed-controlnet-v3.safetensors?download=true"
wget -O models/vae/ae.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/ae.safetensors"


#===NEW V2===
pip install facexlib
pip install filterpy
pip install insightface

cd custom_nodes
git clone https://github.com/balazik/ComfyUI-PuLID-Flux.git
cd ..

mkdir -p models/pulid
wget -O models/pulid/pulid_flux_v0.9.0.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/pulid_flux_v0.9.0.safetensors?download=true"
cd models
conda install -y git-lfs
git lfs install
git clone https://huggingface.co/Aitrepreneur/insightface
git lfs install
git clone https://huggingface.co/Aitrepreneur/CogVideo
cd ..
wget -O models/CogVideo/CogVideoX-5b-I2V/transformer/diffusion_pytorch_model-00001-of-00003.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/diffusion_pytorch_model-00001-of-00003.safetensors?download=true"
wget -O models/CogVideo/CogVideoX-5b-I2V/transformer/diffusion_pytorch_model-00002-of-00003.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/diffusion_pytorch_model-00002-of-00003.safetensors?download=true"
wget -O models/CogVideo/CogVideoX-5b-I2V/transformer/diffusion_pytorch_model-00003-of-00003.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/diffusion_pytorch_model-00003-of-00003.safetensors?download=true"

wget -O models/clip/longclip-L.pt "https://huggingface.co/Aitrepreneur/FLX/resolve/main/longclip-L.pt?download=true"
wget -O models/clip/t5xxl_fp8_e4m3fn.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/t5xxl_fp8_e4m3fn.safetensors?download=true"

wget -O models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/sd_xl_base_1.0_0.9vae.safetensors?download=true"

wget -O models/controlnet/diffusion_pytorch_model_promax.safetensors "https://huggingface.co/Aitrepreneur/FLX/resolve/main/diffusion_pytorch_model_promax.safetensors?download=true"
sudo apt install autossh

# Done
echo "==============Setup complete=============="
echo "Inside the models/upscale_models folder, download the upscaler model: https://openmodeldb.info/models/4x-ClearRealityV1"
echo "vim tunnel to edit the password"
echo "might need to sudo apt install autossh first"