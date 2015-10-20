module RevManifest
  module Helper
    def compute_asset_path(source, options = {})
      if RevManifest.include?(source)
        if RevManifest.enabled?
          RevManifest.resolve(source, options)
        else
          dir = RevManifest.asset_public_directories[options[:type]] || ""
          File.join(dir, source)
        end
      else
        super
      end
    end
  end
end
