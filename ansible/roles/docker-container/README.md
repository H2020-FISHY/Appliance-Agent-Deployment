# Ansible role for deploying docker containers
This role will pull and run your docker images.


## Including into your repository
This role you can use in your project as subtree:
`git subtree add --prefix=ansible/roles/docker-container ssh://git@gitlab.xlab.si:13022/x-collection/deployment/ansible-roles/docker-container.git master --squash`

And later you can update it to latest version with following command:
`git subtree pull --prefix=ansible/roles/docker-container ssh://git@gitlab.xlab.si:13022/x-collection/deployment/ansible-roles/docker-container.git master --squash`


## Usage
Docker service you can run as:
- `docker`: docker container
- `swarm`: swarm service
- `service`: systemd service


### Playbook
In your playbook you define play for `docker-container` role:

```yaml
- hosts: nexus
  become: yes
  pre_tasks:
    - import_tasks: "{{ ansible_dir }}/globals/vars.yml"
  roles:
    - role: docker-container
      service_name: proxy
      service_type: 'docker'
      service_has_config: True
      service_config_format: cfg
      service_config_path: /config.cfg
      service_ports:
        - "80:80"
        - "443:443"
        - "8888:8888"
      service_image: "{{ images.proxy }}:{{ versions.proxy }}"
```

In above example we import pre task for setting optional variables:
- `main_dns`
- `network`
