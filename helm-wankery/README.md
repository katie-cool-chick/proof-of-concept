# Helm Wankery

Headaches with helm deploys...

* Dry Runs
* Real deployments
* Debugging when a real deployment goes wrong.

## Dry Runs

* Should flag when a resource exists already (IE service accounts)
* Should flag when a API is not available
* Should probably flag when an API is deprecated

## Notes

### Tested under microk8s

* a 
```bash
microk8s config > .kube.config
```
