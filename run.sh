source cleanup.sh
source set_hf_cache.sh

echo $HF_DATASETS_CACHE
echo $TRANSFORMERS_CACHE

python -m torch.distributed.run --nproc_per_node 2 fine-tune-dp.py  --output_dir scratch  --model_name gpt2  --sequence_len 128 --per_device_train_batch_size 32 --gradient_accumulation_steps 2 --evaluation_strategy steps --eval_steps 45 --log_level info --per_device_eval_batch_size 32 --eval_accumulation_steps 1 --seed 42 --target_epsilon 8 --per_sample_max_grad_norm 1.0 --prediction_loss_only --weight_decay 0.01 --remove_unused_columns False --num_train_epochs 4 --logging_steps 5 --max_grad_norm 0 --lr_scheduler_type constant --learning_rate 1e-4 --disable_tqdm True --dataloader_num_workers 2 --label_names labels