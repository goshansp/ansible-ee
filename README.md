# ansible-ee
Creates an Ansible Execution Environment.

# Resulting Image
https://quay.io/repository/rh_ee_hgosteli/ansible-ee

# Todo
- integrate bitwarden
- integrate requirements.txt from molecule.git
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
$ podman build --manifest quay.io/rh_ee_hgosteli/ansible-ee --jobs 8 .
$ podman manifest push quay.io/rh_ee_hgosteli/ansible-ee:latest
```

# Debug
```
$ podman run --name=ansible-ee --rm -it quay.io/rh_ee_hgosteli/ansible-ee /bin/sh

```