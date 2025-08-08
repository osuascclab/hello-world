# Hello World Docker Image

A minimal Docker image that demonstrates Docker functionality by printing a "Hello from Docker!" message. This project is a fork of the official Docker hello-world image with enhanced multi-architecture support and GitHub Actions CI/CD.

## What it does

When you run this Docker image, it displays a message that confirms your Docker installation is working correctly. The message explains the steps Docker took to run the container and provides links to Docker documentation.

## Quick Start

### Run the image
```bash
docker run ghcr.io/osuascclab/hello-world
```

### Expected output
```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## Building from Source

### Prerequisites
- Docker with Buildx support
- Git

### Build locally
```bash
# Clone the repository
git clone https://github.com/osuascclab/hello-world.git
cd hello-world

# Build for your current architecture
docker build -t hello-world .

# Run the locally built image
docker run hello-world
```

### Multi-architecture build
```bash
# Build for multiple architectures
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t hello-world:latest .
```

## Project Structure

```
hello-world/
├── hello.c              # C source code for the hello world application
├── Dockerfile           # Multi-stage Dockerfile for building the image
├── .github/workflows/   # GitHub Actions CI/CD configuration
└── README.md           # This file
```

## Technical Details

### C Application (`hello.c`)
- Written in C for minimal image size
- Uses system calls directly for maximum compatibility
- Configurable via preprocessor definitions:
  - `DOCKER_IMAGE`: The image name (default: "hello-world")
  - `DOCKER_GREETING`: The greeting message (default: "Hello from Docker!")
  - `DOCKER_ARCH`: The architecture (set during build)

### Dockerfile
- **Multi-stage build** for minimal final image size
- **Stage 1**: Compiles the C application using `gcc:latest`
- **Stage 2**: Creates a minimal image using `scratch` base
- **Static linking** ensures the binary runs in the minimal environment
- **Architecture-aware** building with `TARGETARCH` argument

### Supported Architectures
- `linux/amd64` (x86_64)
- `linux/arm64` (ARM64)
- `linux/arm/v7` (ARMv7)
- `linux/arm/v5` (ARMv5)
- `linux/ppc64le` (PowerPC 64-bit LE)
- `linux/s390x` (IBM S390x)

## CI/CD Pipeline

This project uses GitHub Actions for automated building and publishing:

### Trigger
- Automatically builds and pushes on version tags (`v*.*.*`)

### Features
- **Multi-architecture builds** for all supported platforms
- **GitHub Container Registry** integration
- **Dynamic tagging** based on Git tags and commits
- **Docker metadata** for proper image labeling

### Manual Release
```bash
# Create and push a new version tag
git tag v1.0.1
git push origin v1.0.1
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test your changes locally
5. Submit a pull request

## License

This project is based on the official Docker hello-world image and is licensed under the MIT License.

## Related Links

- [Docker Documentation](https://docs.docker.com/get-started/)
- [GitHub Container Registry](https://ghcr.io/osuascclab/hello-world)
- [Original Docker hello-world](https://github.com/docker-library/hello-world)
