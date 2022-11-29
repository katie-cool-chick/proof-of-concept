# Helm Wankery

Headaches with helm deploys...

* Dry Runs
* Real deployments
* Debugging when a real deployment goes wrong.

## Dry Runs

* Should flag when a resource exists already (IE service accounts)
* Should flag when a API is not available
* Should probably flag when an API is deprecated
* Should flag when a manifest does not match the API

## Notes

### Tested under microk8s

* a 
```bash
microk8s config > .kube.config
```

### upgrade --install --dry-run

* Catches when resource exists and is not yet managed
* Catches when API is not available
* No non-zero exit code on deprecated API.  Warning is in stderr
* No warning on API mismatch

### upgrade --install

* Catches when resource exists and is not yet managed
* Catches when API is not available
* Catches deprecated APIs with W1129 with 'is deprecated'
* API mismatch gives an unknown field warning and an Error
```
W1129 13:42:29.799572 2374467 warnings.go:70] autoscaling/v2beta2 HorizontalPodAutoscaler is deprecated in v1.23+, unavailable in v1.26+; use autoscaling/v2 HorizontalPodAutoscaler
W1129 13:42:29.872650 2374467 warnings.go:70] autoscaling/v2beta2 HorizontalPodAutoscaler is deprecated in v1.23+, unavailable in v1.26+; use autoscaling/v2 HorizontalPodAutoscaler
W1129 13:42:29.874003 2374467 warnings.go:70] autoscaling/v2beta2 HorizontalPodAutoscaler is deprecated in v1.23+, unavailable in v1.26+; use autoscaling/v2 HorizontalPodAutoscaler
W1129 13:42:29.874014 2374467 warnings.go:70] unknown field "spec.metrics[0].resource.targetAverageUtilization"
Error: UPGRADE FAILED: failed to create resource: HorizontalPodAutoscaler.autoscaling "wankery" is invalid: [spec.metrics[0].resource.target.type: Required value: must specify a metric target type, spec.metrics[0].resource.target.type: Invalid value: "": must be either Utilization, Value, or AverageValue, spec.metrics[0].resource.target.averageUtilization: Required value: must set either a target raw value or a target utilization]
```
* And may cause damage

###
