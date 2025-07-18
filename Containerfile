FROM quay.io/centos/centos:stream10 as builder

RUN dnf install cargo openssh sshpass rsync git python-libvirt python-pip wget -y

RUN mkdir -p /install

RUN wget 'https://files.pythonhosted.org/packages/dd/03/11934ae9d668283895286872a7af3de25d324ec9ac86da5a56ac9dc48544/bitwarden_sdk-1.0.0.tar.gz' && \
tar xf bitwarden_sdk-1.0.0.tar.gz && \
cd bitwarden_sdk-1.0.0 && \
wget 'https://raw.githubusercontent.com/bitwarden/sdk/refs/heads/main/LICENSE' && \
pip install . --prefix=/install

COPY requirements.txt requirements.txt
RUN pip install --prefix=/install -r requirements.txt

RUN pip install ansible
RUN ansible-galaxy collection install bitwarden.secrets


# --------------------------
# STAGE 2: Minimal runtime
# --------------------------
FROM quay.io/centos/centos:stream10

# RUN dnf install openssh sshpass rsync git python3-libvirt wget -y
RUN dnf install openssh-clients -y

COPY --from=builder /install /usr/local

# Set Python path if needed (optional)
# ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages

CMD ["ansible", "--help"]