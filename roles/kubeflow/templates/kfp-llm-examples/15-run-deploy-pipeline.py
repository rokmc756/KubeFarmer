# Upload the deployment pipeline
kfp_client = kfp.Client()
kfp_client.upload_pipeline(pipeline_package_path='llm_deploy_pipeline.yaml', pipeline_name='LLM Deployment Pipeline')


# Run the deployment pipeline
experiment = kfp_client.create_experiment('LLM Deployment Experiment')

run = kfp_client.run_pipeline(
    experiment.id,
    'llm_deploy_pipeline_run',
    'llm_deploy_pipeline.yaml',
    params={'image': '<your-registry-name>.azurecr.io/llm:latest'}
)

