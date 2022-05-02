# Rust as the base image
FROM rust:1.60.0 AS builder_cache

# 1. Create a new empty shell project
WORKDIR /app
COPY . /app
RUN ls ..
RUN ls .
RUN ls /app
RUN ls ./src
RUN cat ./src/main.rs
RUN rm -r ./src/*
RUN echo 'fn main () {}' > ./src/main.rs
RUN ls .
RUN ls ./src
RUN cat ./src/main.rs


# 2. Copy our manifests

# 3. Build only the dependencies to cache them
RUN cargo fetch
RUN cargo build

RUN ls .
RUN ls ./target

#after this last comand, well end with only the target directory on it

FROM rust:1.60.0 AS src_builder



RUN ls

