# galera-node

Multi-arch (amd64 + arm64) container image for a Galera-enabled MariaDB
node: the stock `mariadb` image plus the `galera-4` provider library, which
upstream doesn't ship.

Built from the same `mariadb` base image and digest as
[galera-arbiter](https://github.com/priyankub/galera-arbiter) (`garbd`), so
this image's `libgalera_smm` and `garbd`'s track the same `galera-4`
release.

Published to `ghcr.io/priyankub/galera-node:latest` on every push to `main`
(`.github/workflows/deploy.yml`), built for both `linux/amd64` and
`linux/arm64` in one manifest so the same tag works on any consuming host
regardless of architecture - previously this image was built locally on
each DNS cluster node instead (`docker compose build`), which meant every
deploy that touched the Dockerfile paid for an `apt-get update` + package
install on the Pi itself.

## Usage

Drop-in replacement for a `build:` block pointing at this Dockerfile:

```yaml
services:
  mariadb:
    image: ghcr.io/priyankub/galera-node:latest
    ...
```
