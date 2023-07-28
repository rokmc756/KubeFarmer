from typing import Any, Dict, List
import s3fs
from pyarrow import Table, parquet as pq
from pandas import DataFrame, Series

def to_df(data: List[Dict[str, Any]]) -> DataFrame:                                                                                                         
    df = DataFrame()
    for item in data:
        indexes = []
        values = []
        for k, v in data.items():
            indexes.append(k)
            values.append(v)
        df = df.append(Series(values, index=indexes), ignore_index=True)
    return df

fs = s3fs.S3FileSystem(
    anon=False,
    # key=s3fs_config.aws_access_key_id,
    # secret=s3fs_config.aws_secret_access_key,
    use_ssl=False,
    client_kwargs={
        "region_name": "us-east-1",
        "endpoint_url": "http://localhost:9000",
        "aws_access_key_id": "minio",
        "aws_secret_access_key": "minio-123",
        "verify": False,
    }
)   
path_to_s3_object = "s3://sample-bucket/path/to/sample.parquet"

data = [
  {
    "hoge": 1,
    "foo": "blah",
  },
  {
    "boo": "test",
    "bar": 123,
  },
]
df = to_df(data)
pq.write_to_dataset(
    Table.from_pandas(df),
    path_to_s3_object,
    filesystem=fs,
    use_dictionary=True,
    compression="snappy",
    version="2.0",
)
