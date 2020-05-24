#!/bin/sh

# This file will use the minio command line client to create the 'geneac' bucket

mc alias set minio "$MINIO_ENDPOINT" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY"
mc mb --ignore-existing "minio/$MINIO_BUCKET_NAME"
mc ls "minio/$MINIO_BUCKET_NAME"
