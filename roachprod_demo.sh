############################
# Azure Test
############################

export CLUSTER="chrisc-test"
#roachprod destroy $CLUSTER

### Prepare
#roachprod create ${CLUSTER} -n 5 -c azure --azure-sync-delete
roachprod stage ${CLUSTER} workload
roachprod stage ${CLUSTER} release v19.2.3
roachprod run ${CLUSTER}:1-4 'sudo chmod 777 /mnt/data1/'

### Initialize
roachprod start ${CLUSTER}:1-4
roachprod admin --open ${CLUSTER}:1

### Setup Proxy
echo "install haproxy"
export NODE1=`roachprod ip $CLUSTER:1`
roachprod run $CLUSTER:5 'sudo apt-get update'
roachprod run $CLUSTER:5 'sudo apt-get install -y haproxy'
echo "run haproxy"
roachprod run ${CLUSTER}:5 './cockroach gen haproxy --insecure --host=chrisc-test-0001'
roachprod run ${CLUSTER}:5 'haproxy -f haproxy.cfg &' &

echo "install prometheus"
roachprod run ${CLUSTER}:5 'wget -nv https://github.com/prometheus/prometheus/releases/download/v2.16.0/prometheus-2.16.0.linux-amd64.tar.gz'
roachprod run ${CLUSTER}:5 'tar -xvf prometheus-2.16.0.linux-amd64.tar.gz && mv prometheus-2.16.0.linux-amd64 prometheus'
roachprod put ${CLUSTER}:5 prometheus.yml prometheus/
#roachprod run ${CLUSTER}:5 'cd prometheus && wget https://raw.githubusercontent.com/cockroachdb/cockroach/master/monitoring/prometheus.yml -O prometheus.yml'
roachprod run ${CLUSTER}:5 'cd prometheus && wget -P rules https://raw.githubusercontent.com/cockroachdb/cockroach/master/monitoring/rules/aggregation.rules.yml && wget -P rules https://raw.githubusercontent.com/cockroachdb/cockroach/master/monitoring/rules/alerts.rules.yml'
roachprod run ${CLUSTER}:5 'nohup ./prometheus --config.file=prometheus.yml > prometheus.log 2>&1 &'

echo "Set up app"
roachprod run ${CLUSTER}:5 -- "sudo apt install -y python-pip libpq-dev postgresql-common"
roachprod run ${CLUSTER}:5 -- "pip install psycopg2"
roachprod run ${CLUSTER}:5 -- "git clone https://github.com/chriscasano/commerce.git"
roachprod run ${CLUSTER}:5 -- "./cockroach sql --insecure --host=localhost < commerce/schema.sql"

echo "Run KV Workload"
# Run KV
roachprod run ${CLUSTER}:1 -- "./workload init kv --drop --batch 1 --max-block-bytes 1024 --min-block-bytes 128"
roachprod run ${CLUSTER}:5 -- "./workload run kv --duration 5m --concurrency 10 --read-percent 65 {pgurl:1-3}"

echo "Run Backup"

# Run Backup
#roachprod run ${CLUSTER}:1 -- "./cockroach sql --insecure --host=localhost -e \"backup kv.kv to 'azure://backups/kv?AZURE_ACCOUNT_NAME=chrisc&AZURE_ACCOUNT_KEY=' as of system time '-10s';\""

echo "Rolling Upgrades"

#roachprod run ${CLUSTER} "wget -nv https://binaries.cockroachdb.com/cockroach-v19.2.4.linux-amd64.tgz"
#roachprod run ${CLUSTER} "tar xvf cockroach-v19.2.4.linux-amd64.tgz"

#roachprod run ${CLUSTER}:2 "./cockroach quit --insecure --host=localhost"
#roachprod run ${CLUSTER}:2 "mv cockroach cockroach-19.2.3"
#roachprod run ${CLUSTER}:2 "mv cockroach-v20.1.0-beta.2.linux-amd64/cockroach ./cockroach"
#roachprod run ${CLUSTER}:2 "mv cockroach-v19.2.4.linux-amd64/cockroach ./cockroach"
#roachprod start ${CLUSTER}:2
#roachprod run ${CLUSTER}:1 "./cockroach quit --insecure --host=localhost"
#roachprod run ${CLUSTER}:1 "mv cockroach cockroach-19.2.3"
#roachprod run ${CLUSTER}:1 "mv cockroach-v19.2.4.linux-amd64/cockroach ./cockroach"
#roachprod start ${CLUSTER}:1


# Run Bank
#roachprod run ${CLUSTER}:1 -- "./workload init bank --drop --batch-size 100000 --data-loader IMPORT --rows 1000000 --payload-bytes 500"
#roachprod run ${CLUSTER}:4 -- ./workload run bank --duration 5m {pgurl:1-3}
#roachprod run ${CLUSTER}:4 -- ./workload run bank --duration 5m "postgresql://root@`roachprod ip ${CLUSTER}:1`:26257/bank?sslmode=disable"

# Run YCSB
#roachprod run ${CLUSTER}:1 -- "./workload init ycsb --drop --insert-count 1000000 --data-loader IMPORT"
#roachprod run ${CLUSTER}:4 -- "./workload run ycsb --duration 5m --concurrency=64 --workload=A {pgurl:1-3}"
#roachprod run ${CLUSTER}:4 -- "./workload run ycsb --duration 5m --concurrency=64 --workload=A postgresql://root@`roachprod ip ${CLUSTER}:1`:26257/bank?sslmode=disable"

# Open a SQL connection to the first node.
#roachprod sql ${CLUSTER}:1
