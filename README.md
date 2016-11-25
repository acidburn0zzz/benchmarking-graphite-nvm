# packet portal

* Create new project or use existing one. We're gonna need a project id.
* Create an [new API key token](https://app.packet.net/portal#/api-keys/new) or use an existing one. We're gonna need an api key token.

# terraform

Edit files ...

> A _variables.tf_ file should be created, a sample file is provided as example.

Create the servers.

```
terraform apply
# real  4m52.782s # not bad for a two bare metal servers creation
```

# manual steps

Find out the ip addresses ...

```
terraform show
```


http://<type-0-ip-address>:3000/
admin/admin
Add new datasource
http://<type-0-ip-address>:3000/datasources/new

Name: graphite
Default: [x]
Url: https://<type-1-ip-address>/

Dashboard -> Import dashboard
http://<type-0-ip-address>:3000/dashboard/new?editview=import

Grafana Dashboard: https://grafana.net/dashboards/311


Then launch _haggar_ on the type0 server:


```
export GOPATH=$HOME/work
source ~/.profile
haggar -agents=300 \
  -metrics=2000 \
  -carbon="<type-1-ip-address>:2003"
```


Metrics will be available on the new dashboard available at http://<type-0-ip-address>:3000/dashboard/db/graphite-carbon-metrics-obfuscurity


