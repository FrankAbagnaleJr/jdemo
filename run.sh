#!/bin/bash

# 获取当前目录下的所有 jar 包名
jar_files=$(ls *.jar 2>/dev/null)
APP_HOME=$(pwd)
JVM_OPTS="-Dname=$jar_files  -Duser.timezone=Asia/Shanghai -Xms100m -Xmx120m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=150m -XX:+HeapDumpOnOutOfMemoryError -XX:+PrintGCDateStamps  -XX:+PrintGCDetails -XX:NewRatio=1 -XX:SurvivorRatio=30 -XX:+UseParallelGC -XX:+UseParallelOldGC"
LOG_PATH=$APP_HOME/logs/$jar_files.log
touch $APP_HOME/log.out

if [ -z "$jar_files" ]; then
    echo "当前目录下没有找到任何 jar 包"
    exit 1
fi

for jar_file in $jar_files; do
    # 检查该 jar 包是否已经在运行
    pid=$(pgrep -f $jar_file)
    if [ -n "$pid" ]; then
        echo "进程 $pid 正在运行，将杀掉该进程并重新启动 $jar_file"
        kill $pid
    fi

    # 启动 jar 包
    
	nohup java $JVM_OPTS -jar $jar_file > log.out 2>&1 &
    echo "$jar_file 启动成功"
done
sleep 2

