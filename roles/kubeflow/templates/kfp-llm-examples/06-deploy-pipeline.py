# ip install kfp

kfp_client = kfp.Client()
kfp_client.upload_pipeline(pipeline_package_path='llm_pipeline.yaml', pipeline_name='LLM Training Pipeline')

