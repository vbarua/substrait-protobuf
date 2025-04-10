#!/bin/sh

# Ensure exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <tag>"
    exit 1
fi

TAG="$1"
SPEC_REPO_URL="https://github.com/substrait-io/substrait.git"

# Use git ls-remote to check if the specific tag exists
echo "Checking if tag '$TAG' exists in $SPEC_REPO_URL..."

# Check if the provided tag is in the list
if git ls-remote --tags "$SPEC_REPO_URL" "refs/tags/$TAG" | grep -q .; then
    echo "✅ Tag '$TAG' exists."
else
    echo "❌ Tag '$TAG' does NOT exist."
    exit 2
fi

TARGET="https://github.com/substrait-io/substrait.git#tag=$TAG"
echo "🔧 Executing Protobuf code generation for $TARGET"
buf generate "$TARGET"

echo "Committing generated code"
git add substraitpb-go
git commit -m "feat: compiled Substrait Protobuf for $TAG"
git tag "$TAG" -m "Generated code for spec version $TAG"
