## Introduction.
This repo contains OPA Gatekeeper policy files to implement soft tenancy on kubernetes cluster.

## Installation
To install Gatekeepeer run the below mentioned command.

```yaml
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.8/deploy/gatekeeper.yaml
```
It will create a namespace Gatekeeper on your cluster and deploy pods in that namespace. To check the status of the pods run the below-mentioned command: -

```yaml
kubectl get pods -n gatekeeper-system
```

You will get an Output like this.

```yaml
NAME                                             READY   STATUS    RESTARTS   AGE
gatekeeper-audit-8xy9b59c97-1d9rd                 1/1     Running   0          52s
gatekeeper-controller-manager-355vff9632-jbc75z   1/1     Running   0          52s
gatekeeper-controller-manager-355vff9632-axt25b   1/1     Running   0          52s
gatekeeper-controller-manager-355vff9632-ucd45m   1/1     Running   0          52s
```

## Build a Contraint Template and Constraint.

To enforce our policy on Kubernetes we need to create Constraint Templates and Constraints. The Constraint Template defines a way to validate a set of Kubernetes objects inGatekeeper admission controller. Then constraints are used to inform the Gatekeeper that the admin wants a Constraint Template to be enforced and how to enforce it.

In this example the cluster admin will block the user from creating service loadBalancer.

### Constraint Template

Save the below mentioned file with some name on your local machine. 

```yaml
apiVersion: templates.gatekeeper.sh/v1
kind: ConstraintTemplate
metadata:
  name: k8sblockloadbalancer
  annotations:
    metadata.gatekeeper.sh/title: "Block Services with type LoadBalancer"
    metadata.gatekeeper.sh/version: 1.0.0
    description: >-
      Disallows all Services with type LoadBalancer.

      https://kubernetes.io/docs/concepts/services-networking/service/#loadbalancer
spec:
  crd:
    spec:
      names:
        kind: K8sBlockLoadBalancer
  targets:
    - target: admission.k8s.gatekeeper.sh
      rego: |
        package k8sblockloadbalancer

        violation[{"msg": msg}] {
          input.review.kind.kind == "Service"
          input.review.object.spec.type == "LoadBalancer"
          msg := "User is not allowed to create service of type LoadBalancer"
        }
```

To apply the template use the below mentioned command.

```yaml
kubectl apply -f <template-file.yaml>
```

### Contraint

Save this file on your local machine with a name.

```yaml
apiVersion: constraints.gatekeeper.sh/v1beta1
kind: K8sBlockLoadBalancer
metadata:
  name: block-load-balancer
spec:
  match:
    kinds:
      - apiGroups: [""]
        kinds: ["Service"]
```

To apply the constraint run the below mentioned command.

```yaml
kubectl apply -f  <constraint-file.yaml>
```

## Test

In order to test the policy which we have applied just now, we need to check whether we can create a loadbalancer as service or not. But before jumping on that lets just check the CRD of constraint and constraint template is created or not.

```yaml
kubectl get constraint
kubectl get constrainttemplate
```

Once you see that your CRD are available. Let's try to create the LoadBalancer service. You can use the below given manifest or you can use yours.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service-disallowed
spec:
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30007
```

You will see and error that `User is not allowed to create service type LoadBalancer service.`

And If you try to create a ClusterIP or a NodePort service it will get created. You can use the below given manifest to create a clusterIP service or you can use your own.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service-allowed
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 80
```

# Clean up

To clean your cluster delete the constraint and contraint template file.

```yaml
kubectl apply -f  <constraint-file.yaml>
kubectl apply -f <template-file.yaml>
```

Once the are deleted now you can delete the Gatekeeper.

```yaml
kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
```


Document is completed. You can use the files mentioned in the repo to implement the policies or you can get these files from the [Gatekeeper website](https://open-policy-agent.github.io/gatekeeper-library/website/) 

