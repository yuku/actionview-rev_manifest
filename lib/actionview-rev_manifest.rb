require "rev_manifest/actionview/base"
require "rev_manifest/railtie"
require "rev_manifest/version"

module RevManifest
  DEFAULT_ASSET_PUBLIC_DIRECTORIES = {
    audio:      "/assets/audios",
    font:       "/assets/fonts",
    image:      "/assets/images",
    javascript: "/assets/javascripts",
    stylesheet: "/assets/stylesheets",
    video:      "/assets/videos"
  }

  DEFAULT_ASSET_PREFIXES = {
    audio:      "assets/audios/",
    font:       "assets/fonts/",
    image:      "assets/images/",
    javascript: "assets/javascripts/",
    stylesheet: "assets/stylesheets/",
    video:      "assets/videos/"
  }

  DEFAULT_ASSET_ROOT = "/"

  DEFAULT_MANIFEST_PATH = "public/assets/rev-manifest.json"

  class << self
    attr_writer :enabled, :asset_prefixes, :asset_public_directories, :asset_root, :manifest_path

    #  @return [true, false]
    def enabled?
      !!@enabled
    end

    # @return [Hash]
    def asset_public_directories
      @asset_public_directories || DEFAULT_ASSET_PUBLIC_DIRECTORIES
    end

    # @return [String]
    def resolve(source, options)
      asset_root + manifest[asset_prefixes[options[:type]] + source]
    end

    private

    # @return [Hash]
    def asset_prefixes
      @asset_prefixes || DEFAULT_ASSET_PREFIXES
    end

    # @return [String]
    def asset_root
      @asset_root || DEFAULT_ASSET_ROOT
    end

    # @return [String]
    def manifest_path
      @manifest_path || Rails.root.join(DEFAULT_MANIFEST_PATH)
    end

    def manifest
      @manifest ||= JSON.load(File.read(manifest_path))
    end
  end
end
