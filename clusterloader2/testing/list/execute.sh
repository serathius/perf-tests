#!/bin/bash
export CL2_ENABLE_CONTAINER_RESOURCES_MEASUREMENT=true
export CL2_PROMETHEUS_TOLERATE_MASTER=true
go run ./cmd/clusterloader.go --provider kind -v=4 \
 --testconfig testing/list/config.yaml \
 --kubeconfig $HOME/.kube/config \
 --enable-prometheus-server=true \
 --prometheus-scrape-kube-proxy=false \
 --prometheus-apiserver-scrape-port=6443 \
 --prometheus-scrape-master-kubelets $@