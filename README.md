# Ansible-ee
Creates an Ansible Execution Environment.

# Resulting Image
https://quay.io/repository/rh_ee_hgosteli/ansible-ee


# Known Issues
- starting takes minutes since --userns=keep-id (image pull) and subsequent launches are fast.


# Todo
- solve molecule ssh key issue?
- deploy the alias
- build on quay
- explore shell function in place of alias
- integrate with gitlab-runner
- integrate with ansible_role_controller

### Phase II
- weekly ee builds on quay.io
- have gitlab runner pull latest
- have alias pull latest
- sunset all venvs

### Cleanup
- remove containerfile from ansible_role_controller
- remove ansible from ostree silverblue build

# WIP: Alias
```
alias molecule='podman run --rm -it --userns=keep-id -v "$PWD":/src:z -v $XDG_RUNTIME_DIR/libvirt:/run/user/1000/libvirt:z -w /src quay.io/rh_ee_hgosteli/ansible-ee molecule'
alias ansible-playbook='podman run --rm -it -v "$PWD":/src:z -w /src quay.io/rh_ee_hgosteli/ansible-ee ansible-playbook'

--userns=keep-id makes other terminal sessions hang and sometimes requires several minutes. subsequent launches are okay.

```

# Debug
```
podman run --rm -it --userns=keep-id -v "$PWD":/src:z -v /run/user/1000/libvirt:/run/user/1000/libvirt:z -w /src quay.io/rh_ee_hgosteli/ansible-ee /bin/bash

```


# Build instructions
```
podman login quay.io
podman build -t quay.io/rh_ee_hgosteli/ansible-ee --jobs 8 .
podman push quay.io/rh_ee_hgosteli/ansible-ee
```