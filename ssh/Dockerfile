FROM alpine:3.11
RUN apk add --no-cache \
  openssh-client \
  ca-certificates

ENV SSH_HOST 127.0.0.1
ENV SSH_PORT 22
ENV SSH_USER root
ENV SSH_KEY id_rsa

ENV REMOTE_PORT 8000

ENV K8S_RSC_DNS kubernetes-dashboard
ENV K8S_RSC_PORT 80

# RUN echo 'env' >> entrypoint.sh
RUN echo 'ssh -o "StrictHostKeyChecking no" -i ${SSH_KEY} -l ${SSH_USER} ${SSH_HOST} -p ${SSH_PORT} -R *:${REMOTE_PORT}:${K8S_RSC_DNS}:${K8S_RSC_PORT} -N' >> entrypoint.sh

# Test step
# ADD id_rsa .
# RUN chown nobody:nobody id_rsa
# RUN chmod 600 id_rsa

# Keep in mind - user nobody needs read access to 'id_rsa'
USER nobody

ENTRYPOINT ["sh", "./entrypoint.sh"]

