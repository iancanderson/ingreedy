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
      candidate_locales.each do |locale|
        if dictionary = fetch_dictionary(locale)
          return dictionary
        end
      end

      raise "No dictionary found for locales: #{candidate_locales}"
    end

    private

    def candidate_locales
      Array(Ingreedy.locale || i18n_gem_locales || :en)
    end

    def i18n_gem_locales
      return unless defined?(I18n)

      if I18n.respond_to?(:fallbacks)
        I18n.fallbacks[I18n.locale]
      else
        I18n.locale
      end
    end

    def fetch_dictionary(locale)
      @collection[locale] ||= Dictionary.new load_yaml(locale)
    rescue Errno::ENOENT
    end

    def load_yaml(locale)
      path = File.expand_path(
        File.join(File.dirname(__FILE__), "dictionaries", "#{locale}.yml"),
      )
      YAML.load_file(path)
    end
  end
end
