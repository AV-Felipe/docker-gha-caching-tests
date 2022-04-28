ARG BUILDER_IMAGE=builder_cache

# Rust as the base image
FROM rust:1.60.0 AS builder_cache

# 1. Create a new empty shell project
COPY . ./
RUN ls .
RUN ls ./

# 2. Copy our manifests

# 3. Build only the dependencies to cache them
RUN cargo fetch
RUN cargo build
RUN find . ! -path './target*' -exec rm -rf {} \;  || exit 0
#after this last comand, well end with only the target directory on it

FROM ${BUILDER_IMAGE} AS builder

WORKDIR /app

COPY . .

RUN cargo build
