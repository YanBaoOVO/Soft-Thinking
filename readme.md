# Soft Thinking: Unlocking the Reasoning Potential of LLMs in Continuous Concept Space

<p>
  <a href="https://arxiv.org/abs/2505.15778">
    <img src="https://img.shields.io/badge/arXiv-2505.15778-b31b1b.svg?style=flat" alt="arXiv">
  </a>
  
<a href="https://huggingface.co/papers/2505.15778">
    <img src="https://img.shields.io/badge/HuggingFace-Paper-orange.svg?style=flat" alt="Hugging Face Papers">
  </a>
</p>

This is the official implementation of the paper: [Soft Thinking: Unlocking the Reasoning Potential of LLMs in Continuous Concept Space](https://arxiv.org/abs/2505.15778)

<p align="center">
  <img src="./imgs/softthinking.png" alt="Soft Thinking" width="400"/>
</p>



## 📂 Directory Structure

```plaintext
soft_thinking/
├── datasets/
│   ├── aime2024.json
│   └── ... (other datasets)
├── models/
│   └── download.py
├── scripts/
│   ├── baseline/
│   └── st/
├── sglang_soft_thinking_pkg/
│   └── (sglang files)
├── config.sh
├── codeeval.py
├── convert_livecodebench.py
├── humanevaleval.py
├── mbppeval.py
├── matheval.py
├── run_sglang_softthinking.py
├── run_sglang_nothinking.py
└── ... (other files)
```

## ⚙️ Environment Setup

To set up the virtual environment for SGlang soft thinking inference, execute each line in `config.sh`:

```bash
conda create -n st python=3.11 -y && conda activate st
pip install --upgrade pip
pip install torch transformers accelerate jsonlines math_verify openai torch_memory_saver
pip install flash_attn --no-build-isolation # may take more time (20min). try `pip install flash_attn==2.7.3 --no-build-isolation` if find undefined symbol bug

# install SGlang (0.4.6.post1) tailored for soft thinking
cd sglang_soft_thinking_pkg
pip install -e "python[all]"
cd ..
```

## 🚀 Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-repo/soft_thinking.git
   cd soft_thinking
   ```
2. **Set up the environment**:
   Follow the [Environment Setup](#environment-setup) instructions.
3. **Run a baseline test**:
   ```bash
   bash scripts/baseline/qwq32b.sh
   ```

## 🔄 Reproduction Instructions

### 1. Baseline

Run the baseline script:

```bash
bash scripts/baseline/qwq32b.sh
```

#### 📥 Download the Model

First, download the model to the `models/` directory:

```bash
python ./models/download.py --model_name "Qwen/QwQ-32B"
```

#### 🧠 Run Inference

Then, run the baseline inference:

```bash
python run_sglang_softthinking.py \
    --dataset "aime2024" \
    --model_name "./models/Qwen/QwQ-32B" \
    --max_generated_tokens 32768 \
    --temperature 0.6 \
    --top_p 0.95 \
    --top_k 30 \
    --min_p 0.0 \
    --mem_fraction_static 0.8 \
    --start_idx 0 \
    --end_idx 10000 \
    --num_gpus 8 \
    --num_samples 16  \
    --use_llm_judge \
    --api_base "<replace it>" \
    --deployment_name "<replace it>" \
    --api_version "<replace it>" \
    --api_key "<replace it>" \
    --push_results_to_hf \
    --hf_repo_id "<replace it>" \
    --hf_token "<replace it>"
```

> **Note:**
> - If you use the LLM judge or wish to upload results to Hugging Face, remember to provide the required API information.

---

### 2. Soft Thinking

Run the Soft Thinking script:

```bash
bash scripts/st/qwq32b.sh
```

Or directly execute:

```bash
python run_sglang_softthinking.py \
    --dataset "aime2024" \
    --model_name "./models/Qwen/QwQ-32B" \
    --max_topk 15 \
    --max_generated_tokens 32768 \
    --temperature 0.6 \
    --top_p 0.95 \
    --top_k 30 \
    --min_p 0.0 \
    --after_thinking_temperature 0.6 \
    --after_thinking_top_p 0.95 \
    --after_thinking_top_k 30 \
    --after_thinking_min_p 0.0 \
    --early_stopping_entropy_threshold 0.1 \
    --early_stopping_length_threshold 256 \
    --mem_fraction_static 0.8 \
    --start_idx 0 \
    --end_idx 10000 \
    --num_gpus 8 \
    --num_samples 1 \
    --enable_soft_thinking \
    --use_llm_judge \
    --api_base "<replace it>" \
    --deployment_name "<replace it>" \
    --api_version "<replace it>" \
    --api_key "<replace it>" \
    --push_results_to_hf \
    --hf_repo_id "<replace it>" \
    --hf_token "<replace it>"
```

## 🔍 Hyperparameter Search

To achieve optimal results, tune the following hyperparameters:

- `max_topk`: {5, 10, 15, 20}
- `min_p`: {0.005, 0.01, 0.02}
- `early_stopping_entropy_threshold`: {0.01, 0.05, 0.1, 0.3}
- `early_stopping_length_threshold`: {128, 256, 512, 1024}

> **Note:**
> - Results may vary across different devices even with the same hyperparameters, due to differences in computation precision.
> - You can change the model (`model_name`) and dataset (`dataset`) to experiment with other configurations.

## 📜 Citation

If you use this code or dataset, please cite our paper:

```bibtex
@misc{zhang2025softthinking,
    title={Soft Thinking: Unlocking the Reasoning Potential of LLMs in Continuous Concept Space}, 
    author={Zhen Zhang and Xuehai He and Weixiang Yan and Ao Shen and Chenyang Zhao and Shuohang Wang and Yelong Shen and Xin Eric Wang},
    year={2025},
    eprint={2505.15778},
    archivePrefix={arXiv},
    primaryClass={cs.CL},
    url={https://arxiv.org/abs/2505.15778}, 
}
```
