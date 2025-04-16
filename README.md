# Substrait Protobufs
Repository for generated Protobuf artifacts for the [Substrait specification](https://substrait.io/)

Protobufs are generated based on tagged versions of the Substrait specification in https://github.com/substrait-io/substrait/tree/main/proto

# Languages

## Go
The generated Go protobuf code is not include in the `main` branch. Instead, each version of the spec has a dedicated branch and tag from which it can be accessed.

Generation is managed by the `generate-go.sh` script which is invoked with a specific tag. For example
```sh
./generate-go.sh v0.64.0
```
will:
1. Check that `v0.64.0` is a valid tag in https://github.com/substrait-io/substrait
2. Create a branch `go/v0.64.0`
3. Generate the protobuf code for version `v0.64.0` of the spec into the `go/substraitpb/` directory
4. Commit the generated code, and tag the commit with `go-v0.64.0`

Users can then access the code by referencing the tag.

## Java
TODO

## Rust
TODO