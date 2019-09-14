require 'rest-client'
require 'droplet_kit'
require 'ap'
require 'yaml'

$config = YAML.load(File.read('config.yml'))
unless $config &&
    $config.dig('api_key') &&
    $config.dig('domain', 'id') &&
    $config.dig('domain', 'name') &&
    $config.dig('domain', 'parent_zone')
  raise 'Invalid configuration!'
end

$public_ip = (RestClient.get 'https://api.ipify.org').body

$client = DropletKit::Client.new(access_token: $config['api_key'])

record = DropletKit::DomainRecord.new(name: $config.dig('domain', 'name'), data: $public_ip)
response = $client.domain_records.update(record, for_domain: $config.dig('domain', 'parent_zone'), id: $config.dig('domain', 'id'))

ap response
