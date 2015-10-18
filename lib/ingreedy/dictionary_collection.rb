require "yaml"
require_relative "dictionary"

module Ingreedy
  class DictionaryCollection
    def initialize
      @collection = {}
    end

    def []=(locale, attributes)
      @collection[locale] = Dictionary.new(attributes)
    end

    def current
      @collection[locale] ||= Dictionary.new load_yaml(locale)
    end

    private

    def locale
      Ingreedy.locale || i18n_gem_locale || :en
    end

    def i18n_gem_locale
      I18n.locale if defined?(I18n)
    end

    def load_yaml(locale)
      path = File.expand_path(
        File.join(File.dirname(__FILE__), "dictionaries", "#{locale}.yml"),
      )
      YAML.load_file(path)
    rescue Errno::ENOENT
      raise "No dictionary found for :#{locale} locale"
    end
  end
end
