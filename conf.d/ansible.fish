set -x ANSIBLE_CONFIG $HOME/dev/.ansible.cfg
set -x ANSIBLE_INVENTORY ./hosts.yml
set -x ANSIBLE_VAULT_PASSWORD_FILE $HOME/.ansible/vault-secret
set -x ANSIBLE_ROLES_PATH $HOME/dev/ansible-roles
