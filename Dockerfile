FROM alpine:3.17.3

RUN apk add --update --no-cache openssh-server-pam && \
    adduser -D user && \
    passwd -u user && \
    echo -n 'root:let_root_in' | chpasswd && \
    echo -n 'user:let_user_in' | chpasswd && \
    :

COPY sshd_config /etc/ssh/

# Note: Alpine uses a nonstandard .pam extension here.
COPY sshd.pam /etc/pam.d/

# Again with the .pam extensions.
CMD ["/bin/sh", "-c", "ssh-keygen -A && /usr/sbin/sshd.pam -d"]
