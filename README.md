# Ansible-ee
Creates an Ansible Execution Environment.

# Resulting Image
https://quay.io/repository/rh_ee_hgosteli/ansible-ee

# Todo
- ansible-galaxy install
- create alias
    “mole” that does the molecule stuff … 
    “ans” that does the ansible-playbook stuff …
- integrate with gitlab-runner
- integrate with ansible_role_controller

### Phase II
- weekly ee builds on quay.io
- have gitlab runner pull latest
- have alias pull latest

### Cleanup
- remove containerfile from ansible_role_controller


# Build instructions
```
podman login quay.io
podman manifest create quay.io/rh_ee_hgosteli/ansible-ee
podman build --platform "linux/arm64,linux/amd64" --manifest quay.io/rh_ee_hgosteli/ansible-ee .
podman push quay.io/rh_ee_hgosteli/ansible-ee
```

# Debug
```
$ podman run --rm -it quay.io/rh_ee_hgosteli/ansible-ee /bin/bash

```