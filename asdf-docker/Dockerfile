ARG REGISTRY_DOCKER_THIRDPARTY=docker.io
ARG TAG_DEBIAN=bullseye-20221114
FROM ${REGISTRY_DOCKER_THIRDPARTY}/debian:${TAG_DEBIAN} as build
ARG DEBIAN_FRONTEND=noninteractive
ARG TERM=dumb
RUN apt-get --quiet=2 update && apt-get --quiet=2 --no-install-recommends -y install\
    git=1:2.30.* ca-certificates=202* curl=7.74*\
 && apt-get clean\
 && rm -rf /var/lib/apt/lists/*\
 && git clone https://github.com/asdf-vm/asdf.git -b v0.10.2 /root/.asdf
COPY .tool-versions /root/
ENV PATH /root/.asdf/bin:$PATH
RUN set -x; while read plugin version; do asdf plugin-add "$plugin"; done < /root/.tool-versions\
 && asdf install\
 && asdf current
WORKDIR /result/root
RUN cp -pr /root/.tool-versions /root/.asdf .

FROM ${REGISTRY_DOCKER_THIRDPARTY}/debian:${TAG_DEBIAN}
ENV PATH /root/.asdf/shims:$PATH
COPY --from=build /result/ /