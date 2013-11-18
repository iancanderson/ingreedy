module Ingreedy

  class Rationalizer

    def self.rationalize(options)
      new(options).rationalize
    end

    def initialize(options)
      @integer  = options.fetch(:integer, nil)
      @float    = options.fetch(:float, nil)
      @fraction = options.fetch(:fraction, nil)
    end

    def rationalize
      if @fraction
        result = @fraction.to_r
        if @integer
          result += @integer.to_i
        end
      elsif @integer
        result = @integer.to_r
      elsif @float
        result = @float.to_r
      end

      result
    end

  end

end
