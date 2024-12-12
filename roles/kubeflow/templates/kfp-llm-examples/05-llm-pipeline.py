import kfp

from kfp import dsl
from kfp.components import create_component_from_func


def train_llm() -> str:

    from transformers import AutoModelForCausalLM, AutoTokenizer, Trainer, TrainingArguments
    from datasets import load_dataset

    import torch

    # Load dataset
    dataset = load_dataset("wikitext", "wikitext-2-raw-v1")

    # Load model and tokenizer
    model_name = "gpt2"
    model = AutoModelForCausalLM.from_pretrained(model_name)
    tokenizer = AutoTokenizer.from_pretrained(model_name)


    def tokenize_function(examples):
        return tokenizer(examples["text"], padding="max_length", truncation=True)


    tokenized_datasets = dataset.map(tokenize_function, batched=True)
    tokenized_datasets = tokenized_datasets.remove_columns(["text"])
    tokenized_datasets.set_format("torch")

    # Define training arguments
    training_args = TrainingArguments(
        output_dir="./results",
        evaluation_strategy="epoch",
        learning_rate=2e-5,
        per_device_train_batch_size=8,
        per_device_eval_batch_size=8,
        num_train_epochs=3,
        weight_decay=0.01,
    )

    # Create Trainer
    trainer = Trainer(
        model=model,
        args=training_args,
        train_dataset=tokenized_datasets["train"],
        eval_dataset=tokenized_datasets["validation"],
    )

    # Train model
    trainer.train()

    # Save model
    model_path = "/model"
    model.save_pretrained(model_path)
    tokenizer.save_pretrained(model_path)

    return model_path


train_llm_op = create_component_from_func(
    train_llm, base_image='python:3.8-slim'
)

@dsl.pipeline(
    name='LLM Training Pipeline',
    description='A pipeline to train and deploy a Large Language Model.'
)

def llm_pipeline():
    train_task = train_llm_op()

if __name__ == '__main__':
    kfp.compiler.Compiler().compile(llm_pipeline, 'llm_pipeline.yaml')

