# Ansible-ee
Creates an Ansible Execution Environment.

# Resulting Image
https://quay.io/repository/rh_ee_hgosteli/ansible-ee


# Known Issues
- starting takes minutes since --userns=keep-id (image pull) and subsequent launches are fast.
- selinux needs disabling
```
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: libvirt.libvirtError: Failed to connect socket to '/run/user/1000/libvirt/virtqemud-sock': Permission denied
failed: [localhost] (item=fcos-42..molecule.lab) => {"ansible_loop_var": "item", "changed": false, "item": {"disk_size": "20G", "memory_size": "8", "name": "fcos-42..molecule.lab", "timezone": "Europe/Zurich", "vcpu": 8}, "msg": "Failed to connect socket to '/run/user/1000/libvirt/virtqemud-sock': Permission denied"}
```

# Todo
- the machine shuts off when the container terminates ... its running inside the container. we can not see it from host ui. we see it with virsh and molecule can start it. how can we make it run on the host?
- get molecule running
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
alias molecule='podman run --rm -it --userns=keep-id -v "$PWD":/src:z -v $XDG_RUNTIME_DIR/libvirt:/run/user/1000/libvirt:z -v /dev/kvm:/dev/kvm -v .local/molecule:/src/.local/molecule -w /src quay.io/rh_ee_hgosteli/ansible-ee molecule'

alias ansible-playbook='podman run --rm -it -v "$PWD":/src:z -w /src quay.io/rh_ee_hgosteli/ansible-ee ansible-playbook'

--userns=keep-id makes other terminal sessions hang and sometimes requires several minutes. subsequent launches are okay.

```

# Debug
```
podman run --rm -it --userns=keep-id -v "$PWD":/src:z -v $XDG_RUNTIME_DIR/libvirt:/run/user/1000/libvirt:z -v /dev/kvm:/dev/kvm -w /src quay.io/rh_ee_hgosteli/ansible-ee /bin/bash

virsh list --all

virsh undefine fcos-42..molecule.lab

```


# Build instructions
```
podman login quay.io
podman build -t quay.io/rh_ee_hgosteli/ansible-ee --jobs 8 .
podman push quay.io/rh_ee_hgosteli/ansible-ee
```