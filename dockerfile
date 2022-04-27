# Rust as the base image
FROM rust:1.60.0

# 1. Create a new empty shell project
RUN USER=root cargo new --bin docker-test
WORKDIR /docker-test

# 2. Copy our manifests
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml

# 3. Build only the dependencies to cache them
RUN cargo build
RUN rm src/*.rs

# 4. Now that the dependency is built, copy your source code
COPY ./src ./src

# 5. Build for release.
RUN rm ./target/debug/deps/docker_with_gha*
RUN cargo install --path .
