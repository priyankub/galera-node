# The stock mariadb image has no Galera provider library at all
# (confirmed: no galera/wsrep package in docker-library/mariadb's own
# Dockerfile) - galera-4 is published for arm64 in MariaDB's own apt repo
# at a matching version, so this just adds the one missing package rather
# than switching to a different image/vendor. mariadb-backup (needed for
# wsrep_sst_method=mariabackup) is already in the base image on all archs.
#
# Same base image and digest as galera-arbiter's Dockerfile (garbd) - keeps
# the nodes' libgalera_smm and garbd's on the same galera-4 release. Renovate
# bumps both digests independently; if they drift, the nodes and garbd can
# still talk to each other (the wire protocol is versioned, not tied to the
# packaging), but keeping them matched is the point.
FROM mariadb:13.0.2@sha256:d4fdec0510ad498e4f3127da30a99df3745bd6d5e611ae6ac5f76403d9284a8d
RUN apt-get update && apt-get install -y --no-install-recommends galera-4 && rm -rf /var/lib/apt/lists/*
