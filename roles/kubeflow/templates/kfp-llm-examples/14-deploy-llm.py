from kubernetes import client, config

from kfp.components import create_component_from_func
from kfp import dsl


def deploy_llm(image: str):
    config.load_kube_config()

    deployment = client.V1Deployment(
        metadata=client.V1ObjectMeta(name="llm-deployment"),
        spec=client.V1DeploymentSpec(
            replicas=1,
            selector={'matchLabels': {'app': 'llm'}},
            template=client.V1PodTemplateSpec(
                metadata=client.V1ObjectMeta(labels={'app': 'llm'}),
                spec=client.V1PodSpec(containers=[client.V1Container(
                    name="llm",
                    image=image,
                    ports=[client.V1ContainerPort(container_port=80)]
                )])
            )
        )
    )


    service = client.V1Service(
        metadata=client.V1ObjectMeta(name="llm-service"),
        spec=client.V1ServiceSpec(
            selector={'app': 'llm'},
            ports=[client.V1ServicePort(protocol="TCP", port=80, target_port=80)]
        )
    )

    apps_v1 = client.AppsV1Api()
    core_v1 = client.CoreV1Api()

    apps_v1.create_namespaced_deployment(namespace="default", body=deployment)
    core_v1.create_namespaced_service(namespace="default", body=service)

deploy_llm_op = create_component_from_func(
    deploy_llm, base_image='python:3.8-slim'
)


@dsl.pipeline(
    name='LLM Deployment Pipeline',
    description='A pipeline to deploy a containerized LLM.'
)

def llm_deploy_pipeline(image: str):
    deploy_task = deploy_llm_op(image=image)


if __name__ == '__main__':
    kfp.compiler.Compiler().compile(llm_deploy_pipeline, 'llm_deploy_pipeline.yaml')

