
### Start dashboard

Run Grafana
```
make user_api_docker
```
or
```
docker compose up user_api
```

Open http://localhost:3000

username: `admin` \
password: `admin`

#### Create logs dashboard:
Create new dashboard by import [dashboard/loki_log.json](dashboard/loki_log.json) file

#### Create traces dashboard:
Create new dashboard by import [dashboard/tempo_trace.json](dashboard/tempo_trace.json) file

---

### Start api
Open http://localhost:8080/api/v1/users \
this url random latency time, you can view in traces dashboard

Open http://localhost:8080/api/v1/users/1 \
this url random 500 error time, you can view in logs dashboard

---

Reference
- https://opentelemetry.io/docs/zero-code/java/agent/
- https://github.com/grafana/intro-to-mltp/blob/main/docker-compose-otel.yml
- https://tpbabparn.medium.com/spring-boot-3-3-opentelemetry-agent-with-otel-lgtm-c9ecb100998e