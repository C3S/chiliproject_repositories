#!/bin/env ruby
# encoding: utf-8

require 'redmine'
require 'changeset_patch'

Redmine::Plugin.register :chiliproject_repositories do
  name 'Repositories'
  author 'Alexander Blum'
  description 'This plugin for ChiliProject allows repository commit messages to update all user accessible tickets and adds a menue for them'
  version '0.1'
  author_url 'mailto:alexander.blum@c3s.cc'
  url 'https://github.com/C3S/chiliproject_repositories'
  settings(:default => {
    'fullViewGroupIds' => nil
  }, :partial => 'settings/chiliproject_repositories')
end

# less restrictions for refs/fixes
Dispatcher.to_prepare do
  require_dependency 'changeset'
  Changeset.send(:include, ChangesetPatch)
end