require 'mongoid'

module Ruser
  class Engine < ::Rails::Engine
    isolate_namespace Ruser
  end
end
