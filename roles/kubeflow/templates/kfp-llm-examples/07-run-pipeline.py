# Run the pipeline
experiment = kfp_client.create_experiment('LLM Experiment')
run = kfp_client.run_pipeline(experiment.id, 'llm_pipeline_run', 'llm_pipeline.yaml')

