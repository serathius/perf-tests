watch "kubectl get statefulset | tail -n +2 | sed -E 's/^(\S+)-[0-9]+\s+([0-9]+).*/\1 \2/g' | sort | uniq -c"
