#!/bin/bash

if [ ! -z "$1" ]; then
    cd $1
fi

set -e
set -u

PLATFORM=''
UNAME_PLATFORM=$(uname)

if [[ "$UNAME_PLATFORM" == 'Linux' ]]; then
    PLATFORM='linux'
elif [[ "$UNAME_PLATFORM" == 'Darwin' ]]; then
    PLATFORM='macosx'
else
    echo "Platform not supported"
    exit 1
fi

MACHINE_TYPE=''
UNAME_MACHINE_TYPE=`uname -m`
if [[ "$UNAME_MACHINE_TYPE" == 'x86_64' ]]; then
    MACHINE_TYPE='x64'
else
    MACHINE_TYPE='x86'
fi

TOOLS_DIR="../packages/Grpc.Tools.1.2.2/tools/${PLATFORM}_${MACHINE_TYPE}"
PROTO_DIR="../../proto"

$TOOLS_DIR/protoc -I$PROTO_DIR --grpc_out=. --csharp_out=. --plugin=protoc-gen-grpc=$TOOLS_DIR/grpc_csharp_plugin $PROTO_DIR/ServerSideExtension.proto
