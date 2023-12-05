function Invoke-DownloadFile {
  param (
    [Parameter(Mandatory = $true)] [string] $url,
    [Parameter(Mandatory = $true)] [string] $outputFilePath
  )

  $parentDir = Split-Path -Parent $outputFilePath

  if (!(Test-Path -Path $parentDir)) {
    New-Item -ItemType Directory -Force -Path $parentDir
  }

  if (!(Test-Path -Path $outputFilePath)) {
    try {
      # Write-Output "Downloading $url ..."
      # Write-Output "Saving to $outputFilePath ..."
      Invoke-WebRequest -Uri $url -OutFile $outputFilePath
    }
    catch {
      Write-Error "Failed to download $url"
    }
  }
}

$filesToDownload = @(
  # https://huggingface.co/stabilityai/sd-vae-ft-mse
  # sd-vae-ft-mse
  @{
    url            = "https://huggingface.co/stabilityai/sd-vae-ft-mse/resolve/main/config.json?download=true"
    outputFilePath = "sd-vae-ft-mse/config.json"
  },
  @{
    url            = "https://huggingface.co/stabilityai/sd-vae-ft-mse/resolve/main/diffusion_pytorch_model.safetensors?download=true"
    outputFilePath = "sd-vae-ft-mse/diffusion_pytorch_model.safetensors"
  },

  # https://huggingface.co/runwayml/stable-diffusion-v1-5/
  # stable-diffusion-v1-5
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/scheduler/scheduler_config.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/scheduler/scheduler_config.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/text_encoder/config.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/text_encoder/config.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/text_encoder/pytorch_model.bin?download=true"
    outputFilePath = "stable-diffusion-v1-5/text_encoder/pytorch_model.bin"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/merges.txt?download=true"
    outputFilePath = "stable-diffusion-v1-5/tokenizer/merges.txt"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/special_tokens_map.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/tokenizer/special_tokens_map.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/tokenizer_config.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/tokenizer/tokenizer_config.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/tokenizer/vocab.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/tokenizer/vocab.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/unet/config.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/unet/config.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/unet/diffusion_pytorch_model.bin?download=true"
    outputFilePath = "stable-diffusion-v1-5/unet/diffusion_pytorch_model.bin"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/vae/config.json?download=true"
    outputFilePath = "stable-diffusion-v1-5/vae/config.json"
  },
  @{
    url            = "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/vae/diffusion_pytorch_model.bin?download=true"
    outputFilePath = "stable-diffusion-v1-5/vae/diffusion_pytorch_model.bin"
  }
)

Set-Location $PSScriptRoot

Write-Output "Checking models..."

if (!(Test-Path -Path "pretrained_models")) {
  Write-Output  "Creating pretrained_models..."
  mkdir "pretrained_models"
}

Set-Location .\pretrained_models

if (!(Test-Path -Path "MagicAnimate")) {
  Write-Output  "Downloading ~18GB of MagicAnimate models..."
  git clone https://huggingface.co/zcxu-eric/MagicAnimate
}

foreach ($file in $filesToDownload) {
  Write-Output "Downloading $($file.url) ..."
  Invoke-DownloadFile -url $file.url -outputFilePath $file.outputFilePath
}

Write-Output "Install completed"
Read-Host | Out-Null;
