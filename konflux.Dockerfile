FROM brew.registry.redhat.io/rh-osbs/openshift-golang-builder:rhel_9_golang_1.24 AS builder

COPY . /workspace
WORKDIR /workspace/
ENV GOEXPERIMENT strictfipsruntime
RUN CGO_ENABLED=1 GOOS=linux go build -v -mod=mod -tags strictfipsruntime -o /workspace/bin/velero-plugin-for-gcp ./velero-plugin-for-gcp

FROM registry.redhat.io/ubi9/ubi:latest
RUN dnf -y install openssl && dnf -y reinstall tzdata && dnf clean all
RUN mkdir /plugins
COPY --from=builder /workspace/bin/velero-plugin-for-gcp /plugins/
COPY --from=builder /workspace/LICENSE /licenses/
USER nobody:nogroup
ENTRYPOINT ["/bin/bash", "-c", "cp /plugins/* /target/."]

