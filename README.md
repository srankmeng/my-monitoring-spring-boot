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

### Start database

```sh
docker compose up user_db -d
```

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
kubectl get pod
```

---

### Add Cluster dashboard

Go to Grafana: <http://localhost:3000/>

Add new datasource as `prometheus`

Prometheus server url: `http://prometheus-server.monitoring.svc.cluster.local`

Then go to create new dashboard, you can add from files in <https://github.com/dotdc/grafana-dashboards-kubernetes/tree/master/dashboards>

---

Reference

- <https://opentelemetry.io/docs/zero-code/java/agent/>
- <https://github.com/grafana/intro-to-mltp/blob/main/docker-compose-otel.yml>
- <https://tpbabparn.medium.com/spring-boot-3-3-opentelemetry-agent-with-otel-lgtm-c9ecb100998e>
