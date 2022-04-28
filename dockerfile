# Rust as the base image
FROM rust:1.60.0 AS builder_cache

# 1. Create a new empty shell project
RUN USER=root cargo new --bin docker-test
WORKDIR /docker-test

# 2. Copy our manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# 3. Build only the dependencies to cache them
RUN cargo fetch
RUN cargo build
RUN find . ! -path './target*' -exec rm -rf {} \;  || exit 0

FROM builder_cache AS builder

WORKDIR /docker-test

# 4. Now that the dependency is built, copy your source code
COPY ./src ./src

# 5. Build for release.

RUN cargo build
