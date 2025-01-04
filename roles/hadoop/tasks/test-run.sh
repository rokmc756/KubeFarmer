
kubectl -n hadoop exec -it hadoop-hadoop-yarn-nm-0 -- /opt/hadoop/bin/hadoop jar /opt/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-3.3.2-tests.jar TestDFSIO -write -nrFiles 5 -fileSize 128MB -resFile /tmp/TestDFSIOwrite.txt

kubectl -n hadoop exec -it hadoop-hadoop-yarn-rm-0 -- /opt/hadoop/bin/mapred job -list

