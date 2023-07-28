---
title: ChatGPT-like chatbot
tags: ai
---

ChatGPT-like chatbot:

* [source](ChatGPT-like chatbot using a single GPU)
* [tloen/alpaca-lora](https://github.com/tloen/alpaca-lora)
* Model Card: [tloen/alpaca-lora-7b](https://huggingface.co/tloen/alpaca-lora-7b)
* Hugging Face Demo: [Alpaca-LoRA-Serve](https://huggingface.co/spaces/chansung/Alpaca-LoRA-Serve)
* ChatGPT-style interface: [Alpaca-LoRA-Serve](https://github.com/deep-diver/Alpaca-LoRA-Serve)
* Alpaca Dataset: [AlpacaDataCleaned](https://github.com/gururise/AlpacaDataCleaned)


## Setup

Clone [tloen/alpaca-lora](https://github.com/tloen/alpaca-lora)

Install dependencies using `pip install -r requirements.txt`

## Training

Fine-tune the script to run on the LLaMA model using the cleaned Stanford
Alpaca model.  You can look at the repository to tweak the hyper parameters
for better performance.

```sh
python finetune.py \
    --base_model 'decapoda-research/llama-7b-hf' \
    --data_path 'yahma/alpaca-cleaned' \
    --output_dir './lora-alpaca'
```

## Inference

The inference script reads the foundation LLaMA model from Hugging Face and
loads LoRA weights to run a Gradio interface.
```sh
python generate.py \
    --load_8bit \
    --base_model 'decapoda-research/llama-7b-hf' \
    --lora_weights 'tloen/alpaca-lora-7b'
```

You can

* use [alpaca.cpp](https://github.com/antimatter15/alpaca.cpp) for running
alpaca models on CPU or 4GB RAM Raspberry Pi 4.
* use [Alpaca-LoRA-Serve](https://github.com/deep-diver/Alpaca-LoRA-Serve) to
create a ChatGPT-style interface.
