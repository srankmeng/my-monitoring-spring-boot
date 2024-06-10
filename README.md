# My monitoring spring boot

You can start by docker compose or k3d

## Start by Docker compose

### Start dashboard

Run Grafana

```sh
make user_api_docker
```

or

```sh
docker compose up user_api
```

Open <http://localhost:3000>

username: `admin` \
password: `admin`

---

### Start api

Open <http://localhost:8080/api/v1/users> \
this url random latency time, you can view in traces dashboard

Open <http://localhost:8080/api/v1/users/1> \
this url random 500 error time, you can view in logs dashboard

---

## Start by k3d

### Create cluster

```sh
make cluster
```

### Start dashboard and service

```sh
cd k8s && kubectl apply -f .
```

Open <http://localhost:3000>

username: `admin` \
password: `admin`

---

### Start api service

Open <http://localhost:8080/api/v1/users> \
this url random latency time, you can view in traces dashboard

Open <http://localhost:8080/api/v1/users/1> \
this url random 500 error time, you can view in logs dashboard

---

### Setup Prometheus(node exporters)

Install Helm: <https://helm.sh/docs/intro/install/>

Change directory to `k8s/prometheus`

Add repository

```sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

Update dependencies

```sh
helm dependency update
```

Running prometheus

```sh
helm upgrade -i prometheus . -n monitoring --create-namespace
```

Waiting all pods status are running

```sh
kubectl get pod -n monitoring
```

> Optional: if you want to go to the prometheus site, run this command
>
> ```sh
> kubectl port-forward service/prometheus-server 8881:80 -n monitoring
> ```
>
> Go to <http://localhost:8881>

---

### Setup Postgres exporter

Change directory to `k8s/postgres-exporter`

Update dependencies

```sh
helm dependency update
```

Running prometheus

```sh
helm upgrade -i postgres-exporter . -n monitoring --create-namespace
```

Waiting all pods status are running

```sh
kubectl get pod -n monitoring
```

---

### Add Cluster dashboard

Go to Grafana: <http://localhost:3000/>

Add new datasource as `prometheus`

Prometheus server url: `http://prometheus-server.monitoring.svc.cluster.local`

Then go to create new dashboard

**For cluster dashboard:** you can add from files in <https://github.com/dotdc/grafana-dashboards-kubernetes/tree/master/dashboards>

**For Postgres dashboard:** you can add id `9628`

---

## Try to load test

Install [hey](https://github.com/rakyll/hey)

Running command

```sh
hey -c 20 -z 10s http://localhost:8080/api/v1/users/1
```

---

### Delete cluster

```sh
make cluster_delete
```

---

Reference

- <https://opentelemetry.io/docs/zero-code/java/agent/>
- <https://github.com/grafana/intro-to-mltp/blob/main/docker-compose-otel.yml>
- <https://tpbabparn.medium.com/spring-boot-3-3-opentelemetry-agent-with-otel-lgtm-c9ecb100998e>
- <https://github.com/open-telemetry/opentelemetry-java/blob/main/sdk-extensions/autoconfigure/README.md>
