# asciidoctor-fedora
FROM fedora

LABEL maintainer="Douglas Ramiro <contato@douglasramiro.com.br>"

ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building asciidoctor courses" \
    io.k8s.display-name="builder asciidoctor" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,asciidoctor."

RUN yum install -y asciidoctor \
    && yum install -y nginx

COPY ./nginx.conf /etc/nginx/conf.d/

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# This default user is created in the openshift/base-centos7 image
USER 1001

EXPOSE 8080

CMD ["/usr/libexec/s2i/usage"]
