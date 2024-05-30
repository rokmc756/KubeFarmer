for name in $(kubectl get deployment -o name); do
  kubectl rollout restart "$name"
done
