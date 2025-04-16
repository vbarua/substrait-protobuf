#!/bin/sh

# Ensure exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION="$1"
SPEC_REPO_URL="https://github.com/substrait-io/substrait.git"

# Use git ls-remote to check if the specific tag exists
echo "Checking if tag '$VERSION' exists in $SPEC_REPO_URL"
if git ls-remote --tags "$SPEC_REPO_URL" "refs/tags/$VERSION" | grep -q .; then
    echo "✅ Tag '$VERSION' exists."
else
    echo "❌ Tag '$VERSION' does NOT exist."
    exit 2
fi

BRANCH_NAME="releases/go/$VERSION"
echo "🔨 Creating new branch: $BRANCH_NAME"
git checkout -b "$BRANCH_NAME"

TARGET="https://github.com/substrait-io/substrait.git#tag=$VERSION"
echo "🔧 Executing Protobuf code generation for $TARGET"
buf generate "$TARGET"

echo "Committing generated code"

git add go/substraitpb
git commit -m "generated go/substraitpb for $VERSION"
git push --set-upstream origin "$BRANCH_NAME"

VERSION_TAG="go/$VERSION"
git tag "$VERSION_TAG" -m "Generated Go code for spec version $VERSION"
git push origin "$VERSION_TAG"