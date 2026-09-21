#!/bin/sh

REPOSITORY_ROOT=$(git rev-parse --show-toplevel)
export CL2_LOAD_TEST_THROUGHPUT=50
export CL2_DELETE_TEST_THROUGHPUT=50
export CL2_RATE_LIMIT_POD_CREATION=false
export CL2_PROMETHEUS_TOLERATE_MASTER=true
export CL2_API_AVAILABILITY_PERCENTAGE_THRESHOLD=99.5
export PROMETHEUS_SCRAPE_KUBE_PROXY=false
export CL2_EXECSERVICE_CPU_REQUESTS=1
export CL2_EXECSERVICE_MEMORY_REQUESTS=1Gi

export CL2_ENABLE_API_AVAILABILITY_MEASUREMENT=false # Revert after fixing
export CL2_ENABLE_IN_CLUSTER_NETWORK_LATENCY=false
export CL2_ENABLE_SLO_MEASUREMENT=false

export CL2_ENABLE_INFORMER_LATENCY_TEST=true
export CL2_DAEMONSET_POD_PAYLOAD_SIZE=6000
export CL2_DEPLOYMENT_POD_PAYLOAD_SIZE=6000
export CL2_JOB_POD_PAYLOAD_SIZE=6000
export CL2_DAEMONSET_POD_PAYLOAD_SIZE=6000
export CL2_REALISTIC_POD=true
cd $REPOSITORY_ROOT/clusterloader2/testing/load
go run ../../cmd/clusterloader.go \
  --provider kind \
  -v=4 \
  --testconfig ./config.yaml \
  --kubeconfig $HOME/.kube/config \
  --enable-prometheus-server=true \
  --tear-down-prometheus-server=false \
  --prometheus-scrape-kube-proxy=false \
  --prometheus-apiserver-scrape-port=6443 \
  --prometheus-scrape-master-kubelets \
  --report-dir=report \
  --nodes=10
