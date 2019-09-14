require 'droplet_kit'
require 'ap'
require 'yaml'

$config = YAML.load(File.read('config.yml'))
unless $config &&
    $config.dig('api_key') &&
    $config.dig('domain', 'parent_zone')
  raise 'Invalid configuration!'
end

$client = DropletKit::Client.new(access_token: $config['api_key'])

records = $client.domain_records.all(for_domain: $config.dig('domain', 'parent_zone'))

records.each do |r|
  ap r
end
