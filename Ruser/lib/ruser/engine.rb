require 'mongoid'

module Ruser
  class Engine < ::Rails::Engine
    isolate_namespace Ruser

    config.time_zone = 'Beijing'
    config.i18n.default_locale = "zh-CN"
    #config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]
    config.i18n.load_path += Dir[config.root.join('locales', '*.yml').to_s]
    config.encoding = "utf-8"
  end
end
