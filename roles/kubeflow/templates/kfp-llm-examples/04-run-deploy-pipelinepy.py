# Upload the deployment pipeline
kfp_client.upload_pipeline(pipeline_package_path='iris_deploy_pipeline.yaml', pipeline_name='Iris Deployment Pipeline')

# Run the deployment pipeline
experiment = kfp_client.create_experiment('Iris Deployment Experiment')
run = kfp_client.run_pipeline(experiment.id, 'iris_deploy_pipeline_run', 'iris_deploy_pipeline.yaml', params={'model_path': '<path-to-your-model>'})

