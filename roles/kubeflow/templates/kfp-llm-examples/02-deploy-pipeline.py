# pip install kfp

kfp_client = kfp.Client()

kfp_client.upload_pipeline(pipeline_package_path='iris_pipeline.yaml', pipeline_name='Iris Training Pipeline')

