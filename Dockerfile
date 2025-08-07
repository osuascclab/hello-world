# syntax=docker/dockerfile:1

# Stage 1: Build the C application
FROM gcc:latest AS builder
WORKDIR /app
COPY hello.c .
ARG TARGETARCH
RUN gcc -o hello hello.c -static -DDOCKER_ARCH="\"$TARGETARCH\""

# Stage 2: Create the final minimal image
FROM scratch
WORKDIR /
COPY --from=builder /app/hello /
CMD ["/hello"]
