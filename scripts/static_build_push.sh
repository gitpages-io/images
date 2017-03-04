#!/bin/sh
set -e

# Env vars
BUILD_COMMAND="${BUILD_COMMAND:?Env var BUILD_COMMAND should be set}"
BUILD_DIR="${BUILD_DIR:?Env var BUILD_DIR should be set}"

REPO_NAME="${REPO_NAME:?Env var REPO_NAME should be set}"
REPO_URL="${REPO_URL:?Env var REPO_URL should be set}"
USER_NICK="${USER_NICK:?Env var USER_NICK should be set}"
PROJECT_NAME="${PROJECT_NAME:?Env var PROJECT_NAME should be set}"

MINIO_HOST="${MINIO_HOST:?Env var MINIO_HOST should be set}"
MINIO_ACCESSKEY="${MINIO_ACCESSKEY:?Env var MINIO_ACCESSKEY should be set}"
MINIO_SECRETKEY="${MINIO_SECRETKEY:?Env var MINIO_SECRETKEY should be set}"
MINIO_BUCKET="${MINIO_BUCKET:?Env var MINIO_BUCKET should be set}"

PUSH_TARGET="minio/$MINIO_BUCKET/$USER_NICK/$PROJECT_NAME/"

# Get sources
git clone $REPO_URL
cd $REPO_NAME

# Build
$BUILD_COMMAND

# Push data to minio store
../mc config host add minio $MINIO_HOST $MINIO_ACCESSKEY $MINIO_SECRETKEY
../mc --json mirror --force $BUILD_DIR $PUSH_TARGET
