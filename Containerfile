# Source: https://github.com/alpine-docker/multi-arch-docker-images/blob/master/ansible/Dockerfile
FROM alpine:latest as builder

RUN apk add --update --no-cache ansible bash openssh sshpass rsync git

# workaround: install bitwarden sdk from source (487->+2GB)
RUN ansible-galaxy collection install bitwarden.secrets
RUN apk add --update --no-cache cargo py3-pip pkgconf

RUN mkdir -p /install

RUN wget 'https://files.pythonhosted.org/packages/dd/03/11934ae9d668283895286872a7af3de25d324ec9ac86da5a56ac9dc48544/bitwarden_sdk-1.0.0.tar.gz' && \
tar xf bitwarden_sdk-1.0.0.tar.gz && \
cd bitwarden_sdk-1.0.0 && \
wget 'https://raw.githubusercontent.com/bitwarden/sdk/refs/heads/main/LICENSE' && \
pip install . --prefix=/install --break-system-packages

COPY requirements.txt requirements.txt
RUN pip install --prefix=/install -r requirements.txt --break-system-packages


# --------------------------
# STAGE 2: Minimal runtime
# --------------------------
FROM alpine:latest

# Install only runtime deps
RUN apk add --no-cache \
    python3 \
    py3-pip \
    bash \
    openssh \
    sshpass \
    rsync \
    git

# Copy only installed Python files from builder stage
COPY --from=builder /install /usr/local

# Set Python path if needed (optional)
# ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

CMD ["ansible", "--help"]