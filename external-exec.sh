#!/bin/bash


# Checks if hadoop instance is started
MESSAGE=$( { hdfs dfsadmin -report ;} 2>&1 )
if [[ $MESSAGE == *"java.net.ConnectException"* ]]
then
    echo "HADOOP is stopped! Start hadoop ..."
    /opt/hadoop-2.7.2/sbin/start-dfs.sh
else
    echo "HADOOP is running"
fi



echo "Delete output & output folder"
hadoop fs -rmr /wordcounthadoop/

echo "Create input folder on hadoop fs"
hadoop fs -mkdir /wordcounthadoop
hadoop fs -mkdir /wordcounthadoop/input

echo "Copy input file on hadhoop fs"
hadoop fs -copyFromLocal resource/file01.txt /wordcounthadoop/input

echo "Execute jar ..."
hadoop jar ././target/wordcounthadoop-1.0-SNAPSHOT.jar html.it.hadoop.wordcount.Main /wordcounthadoop/input /wordcounthadoop/output