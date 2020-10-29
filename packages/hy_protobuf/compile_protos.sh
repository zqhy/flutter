#!/usr/bin/env bash
echo "$PWD"
rm -rf lib/generated/protos
mkdir -p lib/generated/protos/google/protobuf
files=$(find protos -iname  "*.proto")
for file in $files;do
  protoc --proto_path=protos --dart_out=lib/generated/protos "$file"
done

#dartfmt -w lib/generated/protos

find lib/generated/protos -name "*.pbenum.dart" -exec rm -f {} \;
find lib/generated/protos -name "*.pbjson.dart" -exec rm -f {} \;
find lib/generated/protos -name "*.pbserver.dart" -exec rm -f {} \;