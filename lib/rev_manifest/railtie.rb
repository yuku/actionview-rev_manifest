module RevManifest
  class Railtie < ::Rails::Railtie
    config.rev_manifest = ActiveSupport::OrderedOptions.new

    config.rev_manifest.enabled = false
    config.rev_manifest.sources = :all

    initializer "rev_manifest.config", group: :all do |app|
      RevManifest.enabled = app.config.rev_manifest.enabled
      RevManifest.sources = app.config.rev_manifest.sources
    end
  end
end
