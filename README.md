# Ansible-ee
Creates an Ansible Execution Environment.

# Resulting Image
https://quay.io/repository/rh_ee_hgosteli/ansible-ee


# WIP: Alias
```
alias molecule='podman run --rm -it -v "$PWD":/src:z -w /src quay.io/rh_ee_hgosteli/ansible-ee molecule'
alias ansible-playbook='podman run --rm -it -v "$PWD":/src:z -w /src quay.io/rh_ee_hgosteli/ansible-ee ansible-playbook'
```


# Todo
- create alias
    “molecule” that does the molecule stuff … 
    “ansible-playbook” that does the ansible-playbook stuff …
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


# Build instructions
```
podman login quay.io
podman manifest create quay.io/rh_ee_hgosteli/ansible-ee
podman build --platform "linux/arm64,linux/amd64" --manifest quay.io/rh_ee_hgosteli/ansible-ee .
podman push quay.io/rh_ee_hgosteli/ansible-ee
```

# Debug
```
$ podman run --rm -it -v "$PWD":/src:z -w /src quay.io/rh_ee_hgosteli/ansible-ee /bin/bash

```