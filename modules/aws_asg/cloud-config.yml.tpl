#cloud-config
# vim:filetype=yaml

write_files:
- content: '${base64encode(github_users_env)}'
  encoding: b64
  path: /etc/default/github-users
- content: '${base64encode(worker_config)}'
  encoding: b64
  owner: 'travis:travis'
  path: /etc/default/travis-worker
- content: '${base64encode(cloud_init_env)}'
  encoding: b64
  owner: 'travis:travis'
  path: /etc/default/travis-worker-cloud-init
- content: '${base64encode(cloud_init_bash)}'
  encoding: b64
  path: /var/lib/cloud/scripts/per-instance/99-travis-worker-cloud-init
  permissions: '0750'
- content: '${base64encode(cyclist_url)}'
  encoding: b64
  owner: 'travis:travis'
  path: /var/tmp/travis-run.d/cyclist-url
- content: '${base64encode(hostname_tmpl)}'
  encoding: b64
  owner: 'travis:travis'
  path: /var/tmp/travis-run.d/instance-hostname.tmpl
- content: '${base64encode(prestart_hook_bash)}'
  encoding: b64
  owner: 'travis:travis'
  path: /var/tmp/travis-run.d/travis-worker-prestart-hook
  permissions: '0750'
- content: '${base64encode(start_hook_bash)}'
  encoding: b64
  owner: 'travis:travis'
  path: /var/tmp/travis-run.d/travis-worker-start-hook
  permissions: '0750'
- content: '${base64encode(stop_hook_bash)}'
  encoding: b64
  owner: 'travis:travis'
  path: /var/tmp/travis-run.d/travis-worker-stop-hook
  permissions: '0750'
- content: '${base64encode(syslog_address)}'
  encoding: b64
  path: /var/tmp/travis-run.d/syslog-address
- content: '${base64encode(unregister_netdevice_crontab)}'
  owner: 'root:root'
  path: /etc/cron.d/unregister-netdevice-shutdown
- content: '${base64encode(handle_unregister_netdevice_bash)}'
  owner: 'root:root'
  path: /var/tmp/travis-run.d/handle-unregister-netdevice
  permissions: '0750'
