#! /bin/sh
#
# micro_bench.sh
PWD=`pwd`
export JAVA_HOME=${PWD}/thirdparty/jdk1.8.0_141
export PATH=${PWD}/thirdparty/bin:$JAVA_HOME/bin:${PWD}/thirdparty/apache-maven-3.6.3/bin:$PATH

mkdir -p build && cd build 
cmake .. -DCMAKE_BUILD_TYPE=Release -DBENCHMARK_ENABLE_LTO=true -DCOVERAGE_ENABLE=OFF -DTESTING_ENABLE=OFF
make fesql_proto
make fesql_parser
make -j16 engine_bm fesql_client_bm fesql_client_batch_run_bm
echo "engine benchmark:"
src/vm/engine_bm 2>/dev/null

echo "fesql client one run benchmark:"
src/bm/fesql_client_bm 2>/dev/null

echo "fesql client batch run benchmark:"
src/bm/fesql_client_batch_run_bm 2>/dev/null

