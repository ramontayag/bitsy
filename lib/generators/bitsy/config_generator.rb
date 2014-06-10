require "bitsy/engine"

module Bitsy
  class ConfigGenerator < Rails::Generators::Base

    desc "Creates a Bitsy config file in config/bitsy.yml, and initializer that loads the file"
    source_root File.expand_path("../config/templates", __FILE__)

    def create_config_file
      copy_file "bitsy.yml", File.join("config", "bitsy.yml")
    end

    def create_initializer_file
      copy_file(
        "initializer.rb",
        File.join("config", "initializers", "bitsy.rb"),
      )
    end

    def ignore_bitsy_yml
      append_file ".gitignore", "config/bitsy.yml"
    end

  end
end
