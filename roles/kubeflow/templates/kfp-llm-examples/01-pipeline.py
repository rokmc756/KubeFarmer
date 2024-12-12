
import kfp

from kfp import dsl
from kfp.components import create_component_from_func


def train_model() -> str:

    import pandas as pd
    from sklearn.datasets import load_iris
    from sklearn.linear_model import LogisticRegression
    from sklearn.model_selection import train_test_split
    import joblib

    iris = load_iris()
    X_train, X_test, y_train, y_test = train_test_split(iris.data, iris.target, test_size=0.2)

    clf = LogisticRegression()
    clf.fit(X_train, y_train)

    accuracy = clf.score(X_test, y_test)
    print(f"Model accuracy: {accuracy}")

    model_path = "/model.pkl"
    joblib.dump(clf, model_path)

    return model_path

train_model_op = create_component_from_func(
    train_model, base_image='python:3.8-slim'
)


@dsl.pipeline(

    name='Iris Training Pipeline',
    description='A pipeline to train and deploy an Iris classification model.'

)
def iris_pipeline():

    train_task = train_model_op()

if __name__ == '__main__':
    kfp.compiler.Compiler().compile(iris_pipeline, 'iris_pipeline.yaml')


