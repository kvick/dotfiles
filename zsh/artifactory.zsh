function apsql() {
    if [ -z "$1" ]; then
        echo "A stack must be specified"
        return 1
    fi
    local region="us-west-2"
    local stack="$1"
    if [ "$1" = "recovery" ]; then
        region="us-east-1"
    fi
    echo "Starting psql for stack $stack region $region"
    ssh -t aws.mgmt.netflix.net oq-ssh -r "$region" artifactory-metrics-stable-v,0 -t "/apps/artifactory-metrics/bin/runp.sh psql $stack"
}

function apg_activity() {
    if [ -z "$1" ]; then
        echo "A stack must be specified"
        return 1
    fi
    local region="us-west-2"
    local stack="$1"
    if [ "$1" = "recovery" ]; then
        region="us-east-1"
    fi
    echo "Starting pg_activity for stack $stack region $region"
    ssh -t aws.mgmt.netflix.net oq-ssh -r "$region" artifactory-metrics-stable-v,0 -t "/apps/artifactory-metrics/bin/runp.sh pg_activity $stack"
}

function aql() {
    local apikey_file="$HOME/.artifactory-apikey"
    if [ ! -f "$apikey_file" ]; then
        echo "You must have a file $apikey_file with the API key to use"
        return 1
    fi
    if [ -z "$1" ]; then
        echo "A file with an AQL query must be specified"
        return 1
    fi
    if [ ! -f "$1" ]; then
        echo "$1 does not exist"
        return 1
    fi
    curl  -s -H "Content-Type: text/plain" -H "X-JFrog-Art-Api: $(cat $apikey_file | head -1)" https://artifacts.netflix.net/api/search/aql -d "@$1"
}

function anewt() {
    : ${artifactory_version=latest}
    dir="$HOME/.artifactory_develop"
    mkdir -p "$dir"
    pushd "$dir" > /dev/null
    trap "{ popd > /dev/null }" EXIT

    if [ "$1" = "build" ]; then
        if [ ! -f "artifactory.lic" ]; then
            curl -s -k --cacert "$HOME/.metatron/certificates/netflixInternalServices.trust.pem" --key ~/.metatron/certificates/user.key --cert ~/.metatron/certificates/user.crt https://stash.prod.netflix.net:7006/projects/CISYS/repos/artifactory/raw/root/apps/nflx-artifactory/etc/artifactory.cluster.license.unstable -o "artifactory.lic"
        fi
    cat > Dockerfile << EOF
FROM docker.bintray.io/jfrog/artifactory-pro:$artifactory_version
COPY artifactory.lic /artifactory_extra_conf/
EOF

        libyjpagent="/Applications/YourKit.app/Contents/Resources/bin/linux-x86-64/libyjpagent.so"
        if [ -f "$libyjpagent" ]; then
            cp "$libyjpagent" "$dir"
            echo "COPY libyjpagent.so /opt/jfrog/artifactory/bin/libyjpagent.so" >> Dockerfile
            echo "ENV EXTRA_JAVA_OPTIONS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006 -agentpath:/opt/jfrog/artifactory/bin/libyjpagent.so=port=10001,listen=all,probe_disable=*" >> Dockerfile
        else
            echo "ENV EXTRA_JAVA_OPTIONS -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5006" >> Dockerfile
        fi
    fi

    cat > .newt.yml << EOF
command-configs:
  develop:
    required-ports:
        - 8081:8081
        - 10001:10001
        - 5006:5006
EOF

    newt "$@"
}

function assh() {
    if [ -z "$1" ]; then
        echo "A stack must be specified"
        return 1
    fi
    local region="us-west-2"
    local stack="$1"
    if [ "$1" = "recovery" ]; then
        region="us-east-1"
    fi
    local bastion="awsmgmt.test.netflix.net"
    if [ "$1" = "recovery" ] || [ "$1" = "stable" ]; then
        bastion="awsmgmt.prod.netflix.net"
    fi
    echo "Connecting to first $stack instance..."
    ssh -t "$bastion" -L 5005:localhost:8007 -L 10001:localhost:8008 "oq-ssh --region us-west-2 artifactory-artifacts-$stack-v,0 -L 8007:localhost:8007 -L 8008:localhost:8008"
}
