# syntax=docker/dockerfile:1

# Stage 1: Build the C application
FROM gcc:latest as builder
WORKDIR /app
COPY hello.c .
RUN gcc -o hello hello.c -static

# Stage 2: Create the final minimal image
FROM scratch
WORKDIR /
COPY --from=builder /app/hello /
CMD ["/hello"]
