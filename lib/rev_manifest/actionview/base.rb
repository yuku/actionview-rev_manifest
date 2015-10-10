module ActionView
  class Base
    # @note Override {ActionView::Helpers::AssetUrlHelper#compute_asset_path}.
    def compute_asset_path(source, options = {})
      if RevManifest.enabled?
        RevManifest.manifest[RevManifest.asset_prefixes[options[:type]] + source]
      else
        dir = RevManifest.asset_public_directories[options[:type]] || ""
        File.join(dir, source)
      end
    end
  end
end
