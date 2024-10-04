# frozen_string_literal: true

require "resque/tasks"

desc "Preload resque environment"
task "resque:preload" => :environment
