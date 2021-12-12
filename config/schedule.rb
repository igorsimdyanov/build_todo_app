# frozen_string_literal: true

set :environment, ENV['RAILS_ENV']
set :output, error: 'log/cron_error.log', standard: 'log/cron.log'
set :chronic_options, hours24: true

every :minute do
  rake 'touch:hello_from_whenever'
  runner 'Hello.touch'
end
