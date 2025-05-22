python ./models/download.py --model_name "Qwen/QwQ-32B"

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
    --hf_token "<replace it>" \