#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rabbithole::Application.load_tasks

namespace :test do
  desc "Run tests with coverage enabled"
  task :coverage do
    ENV['COVERAGE'] = 'on'
    FileUtils.rm_r 'coverage', :force => true
    Rake::Task["test"].invoke
  end
end
