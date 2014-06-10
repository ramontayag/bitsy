module Bitsy
  class Engine < Rails::Engine
    isolate_namespace Bitsy
    engine_name "bitsy"
    config.autoload_paths << File.expand_path("../../lib", __FILE__)
  end
end
