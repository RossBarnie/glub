#!/usr/bin/env ruby

require 'rest_client'
require 'json'
require 'yaml'
require 'thor'

class Glub < Thor 

  config = YAML::load_file "#{ENV['HOME']}/.gitlab"
  @@api_key = config['api_key']
  @@api_endpoint = config['api_endpoint']

  desc "create NAME", "Creates a new Gitlab project"
  def create(project_name)

    puts "Creating Gitlab project #{project_name}"
    command = { 
        :name => project_name,
        :description  => 'this is a new project',
        :default_branch => 'master',
        :issues_enabled => 'true',
        :wiki_ebabled  => 'true',
        :wall_enabled  => 'true',
        :merge_requests_enabled => 'true'
    } 

    RestClient.post( 
       "#{@@api_endpoint}/projects?private_token=#{@@api_key}",
       command.to_json,
       :content_type => 'application/json'
    ) 
  end

end


