config = YAML.load_file('config/deploy-config.yml') || {}

set :rails_env, 'production'

role :app, config['hosts']['app']
role :web, config['hosts']['web']
role :db,  config['hosts']['db']

set :ssh_options, {
  forward_agent: false,
  auth_methods: %w[publickey],
  host_key: config.fetch('host_key') { %w[ecdsa-sha2-nistp256 ssh-rsa] },
  user: config['user']
}
