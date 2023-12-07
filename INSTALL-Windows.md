# Windows Installation

This is tested with Python 3.10.6, Windows 10, RTX 4080 with NVIDIA graphics driver 536.67. No CUDA Toolkit or cuDNN installed.

- [Download and install ffmpeg](https://ffmpeg.org/download.html#build-windows), the binary must be in your PATH.

Clone this repo

    git clone https://github.com/andygock/magic-animate
    cd magic-animate

Install venv, if you have multiple versions of Python installed, you will want to use full path to the desired Python binary dir

    c:\Python\Python310\python -m venv venv
    .\venv\Scripts\activate
    pip install -r requirements-windows.txt

## Adding `pretrained_models/`

    mkdir pretrained_models
    cd pretrained_models
    git lfs clone https://huggingface.co/zcxu-eric/MagicAnimate

MagicAnimate has 18 GB of files.

Now we need to selectively download files for [sd-vae-ft-mse](https://huggingface.co/stabilityai/sd-vae-ft-mse) and [stable-diffusion-v1-5](https://huggingface.co/runwayml/stable-diffusion-v1-5). You could git clone the entire lot of large files and it will work, but selectively downloading will save a lot more disk space, time and bandwidth.

We only need the following files in `pretrained_models/`.

```txt
MagicAnimate/*
sd-vae-ft-mse/config.json
sd-vae-ft-mse/diffusion_pytorch_model.safetensors
stable-diffusion-v1-5/scheduler/scheduler_config.json
stable-diffusion-v1-5/text_encoder/config.json
stable-diffusion-v1-5/text_encoder/pytorch_model.bin
stable-diffusion-v1-5/tokenizer/merges.txt
stable-diffusion-v1-5/tokenizer/special_tokens_map.json
stable-diffusion-v1-5/tokenizer/tokenizer_config.json
stable-diffusion-v1-5/tokenizer/vocab.json
stable-diffusion-v1-5/unet/config.json
stable-diffusion-v1-5/unet/diffusion_pytorch_model.bin
stable-diffusion-v1-5/v1-5-pruned-emaonly.safetensors
stable-diffusion-v1-5/vae/config.json
stable-diffusion-v1-5/vae/diffusion_pytorch_model.bin
```

### Automatic download (recommended)

Run `download_pretrained_models.ps1` from the project's root directory will download all the required `sd-vae-ft-mse/` and `stable-diffusion-v1-5/` files into the correct dirs.

    powershell.exe -ExecutionPolicy Bypass -File download_pretrained_models.ps1

If you already any of the files, manually create the dir structure and put the files in there. The downloader script will skip downloading files if they already exist in the correct target dir. Any other extra files in the target dir will be left alone.

### Manual download

Note when you download the non LFS files, the default filename is likely to be incorrect, e.g `vae/config.json` will be downloaded as `vae_config.json`. You will need to rename the files to the correct name and place into the correct dir.

Create all required dirs

    mkdir pretrained_models/sd-vae-ft-mse
    mkdir pretrained_models/stable-diffusion-v1-5
    mkdir pretrained_models/stable-diffusion-v1-5/scheduler
    mkdir pretrained_models/stable-diffusion-v1-5/text_encoder
    mkdir pretrained_models/stable-diffusion-v1-5/tokenizer
    mkdir pretrained_models/stable-diffusion-v1-5/unet
    mkdir pretrained_models/stable-diffusion-v1-5/vae

Here are the download links on [HuggingFace](https://huggingface.co/):

Download into `pretrained_models/sd-vae-ft-mse/` (319 MB):

| Selected                              | Download URL                                                                                                             |
| ------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `config.json`                         | [Download](https://huggingface.co/runwayml/sd-vae-ft-mse/resolve/main/config.json?download=true)                         |
| `diffusion_pytorch_model.safetensors` | [Download](https://huggingface.co/runwayml/sd-vae-ft-mse/resolve/main/diffusion_pytorch_model.safetensors?download=true) |

Download into `pretrained_models/stable-diffusion-v1-5/` (7 GB):

| Selected                            | Download URL                                                                                                                   |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `scheduler/scheduler_config.json`   | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/scheduler/scheduler_config.json?download=true)   |
| `text_encoder/config.json`          | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/text_encoder/config.json?download=true)          |
| `text_encoder/pytorch_model.bin`    | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/text_encoder/pytorch_model.bin?download=true)    |
| `tokenizer/merges.txt`              | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/merges.txt?download=true)              |
| `tokenizer/special_tokens_map.json` | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/special_tokens_map.json?download=true) |
| `tokenizer/tokenizer_config.json`   | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/tokenizer_config.json?download=true)   |
| `tokenizer/vocab.json`              | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/vocab.json?download=true)              |
| `unet/config.json`                  | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/unet/config.json?download=true)                  |
| `unet/diffusion_pytorch_model.bin`  | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/unet/diffusion_pytorch_model.bin?download=true)  |
| `vae/config.json`                   | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/vae/config.json?download=true)                   |
| `vae/diffusion_pytorch_model.bin`   | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/vae/diffusion_pytorch_model.bin?download=true)   |
| `v1-5-pruned-emaonly.safetensors`   | [Download](https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors?download=true)   |

## Run

To start Gradio demo, run `run_gradio_demo.cmd`
