module ActionView
  class Base
    # @note Patch {ActionView::Helpers::AssetUrlHelper#compute_asset_path}.
    def compute_asset_path_with_rev_manifest(source, options = {})
      if RevManifest.include?(source)
        if RevManifest.enabled?
          RevManifest.resolve(source, options)
        else
          dir = RevManifest.asset_public_directories[options[:type]] || ""
          File.join(dir, source)
        end
      else
        compute_asset_path_without_rev_manifest(source, options)
      end
    end

    alias_method_chain :compute_asset_path, :rev_manifest
  end
end
