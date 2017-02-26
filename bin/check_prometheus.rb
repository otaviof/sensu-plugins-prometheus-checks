#!/usr/bin/env ruby

require 'yaml'
require 'sensu/plugins/prometheus/checks/runner'

config_file = ARGV[0] || 'config.yml'
abort("Can't find configuration file at '#{config_file}'") \
  unless File.exist?(config_file)

run = nil

begin
  run = Sensu::Plugins::Prometheus::Checks::Runner.new(
    YAML.load_file(config_file)
  )
  run.run
rescue RuntimeError => e
  puts "ERROR: #{e}"
  exit(1)
end

puts "\n"
puts run.output
exit(run.status)
