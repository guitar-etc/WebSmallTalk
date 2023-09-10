set -ex

pushd ./scripts

./init.sh
./ci.sh
./cd.sh
