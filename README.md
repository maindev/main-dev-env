## main-dev-env

`main-dev-env` is an startup development environment which allows you to get started quickly with all the tools you need. This is dedicated for single-node usage and does not include ditributed filesystem solution. The only thing you need to do is to modify one file with your company information and execute one command to have it deployed. It will deploy the following toolset:
- nginx ingress controller to serve your toolset and applications if you want to
- cert-manager to issue certificates
- OpenLDAP to store user database in known and battletested format
- Keycloak to manage user accounts
- Gitlab to keep your code safe and run jobs in CI
- Docker registry
- Nexus to store your artifacts
- Prometheus and grafana to have everything under controll and notice issues right away.

And will connect everything together. So you can manage your users by creating them in Keycloak and then use this accounts to login to Gitlab, Docker registry, Nexus and Grafana.

### Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) >= v1.17.3
- [helm](https://github.com/helm/helm#install) >= v3.1.0
- [helm-diff plugin](https://github.com/databus23/helm-diff#install) >= v3.1.0
- [helmfile](https://github.com/roboll/helmfile#installation) >= 0.100.0


> *It is possible that everything will work fine with older versions of the software, but this are the versions which are already proven to work*

### Installation

1. Get the machine and assign wildcard domain to it, e.g. `*.example.com`.

2. Login to the machine and install k3s:

    ```bash
    $ curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --default-local-storage-path /data"  sh -s -
    ```

    Notes:

    > *We are not deploying `traefik` as we are going to use `nginx` as ingress controller.*

    > *You can change the location for `local-path-provisioner` by changing `/data` into something else in above command.

2. Then learn how to access your cluster, either locally or from the outside. The official guide lies [here](https://rancher.com/docs/k3s/latest/en/cluster-access/).

    > *If you want to access it from the outside, then you need to open ports 6443 on firewall for k3s master API access and ports 80/443 for HTTP.*

5. Clone this repository

    ```bash
    $ git clone git@github.com:maindev/main-dev-env.git
    ```

6. Edit `config.yaml` with your details.

7. Execute

    ```bash
    $ helmfile sync
    ```

and all the components will land on your cluster. More on the `helmfile` commands can be found [here](https://github.com/roboll/helmfile#cli-reference).

## Future plans

- make nexus LDAP connection automatic
- introduce storage solution
- allow multinode cluster
- add configuration options to choose what to install
- ...