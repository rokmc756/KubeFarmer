from kubernetes import client, config

def deploy_model(model_path: str):

    config.load_kube_config()

    # Define deployment specs
    deployment = client.V1Deployment(
        metadata=client.V1ObjectMeta(name="iris-model-deployment"),
        spec=client.V1DeploymentSpec(
            replicas=1,
            selector={'matchLabels': {'app': 'iris-model'}},
            template=client.V1PodTemplateSpec(
                metadata=client.V1ObjectMeta(labels={'app': 'iris-model'}),
                spec=client.V1PodSpec(containers=[client.V1Container(
                    name="iris-model",
                    image="mydockerhub/iris-model:latest",
                    ports=[client.V1ContainerPort(container_port=80)]

                )])
            )
        )
    )

    # Create deployment
    apps_v1 = client.AppsV1Api()
    apps_v1.create_namespaced_deployment(namespace="default", body=deployment)

deploy_model_op = create_component_from_func(
    deploy_model, base_image='python:3.8-slim'
)



@dsl.pipeline(

    name='Iris Deployment Pipeline',
    description='A pipeline to deploy an Iris classification model.'

)

def iris_deploy_pipeline(model_path: str):
    deploy_task = deploy_model_op(model_path)


if __name__ == '__main__':
    kfp.compiler.Compiler().compile(iris_deploy_pipeline, 'iris_deploy_pipeline.yaml')

