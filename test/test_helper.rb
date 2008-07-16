$:.unshift(File.dirname(__FILE__) + '/../lib')

# Setup
require 'test/unit'
require 'rubygems'
begin; require 'turn'; rescue LoadError; end # I like this gem for test result output

require 'active_support'
require 'active_record'
require 'active_record/fixtures'

require 'ruby-debug'
Debugger.settings[:autoeval] = true
Debugger.start

require 'test/models'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.configurations = config
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Base.establish_connection(config[ENV['DB'] || 'sqlite3'])

load(File.join(File.dirname(__FILE__), 'schema.rb'))
require File.join(File.dirname(__FILE__), '../init')
