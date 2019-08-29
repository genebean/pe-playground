# pe-playground

Builds a Puppet Enterprise box inside Vagrant so long
as you first download an installation tarball and
place it in this directory.

## Logging in

```
user: admin
pass: puppet
```

## Allowing agents to pick their own environment

```
vagrant ssh pe
puppet module install WhatsARanjit-node_manager
puppet apply /vagrant/node_group.pp
```

