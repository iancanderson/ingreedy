require 'unicode'

module Ingreedy
  module CaseInsensitiveParser
    def stri(str)
      key_chars = str.split(//)
      key_chars.
        map! { |char| match["#{Unicode.upcase(char)}#{Unicode.downcase(char)}"] }.
        reduce(:>>)
    end
  end
end
