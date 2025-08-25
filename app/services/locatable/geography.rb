module Locatable
  module Geography
    class << self

      def countries
        CS.countries
      end

      def states(country_code)
        CS.states(country_code)
      end

      def cities(country_code, state_code)
        CS.cities(state_code.to_sym, country_code.to_sym)
      end

      def country_name(code)
        return nil unless code

        normalized = code.to_s.upcase
        CS.countries[normalized.to_sym]
      end

      def state_name(state_code, country_code)
        return nil unless country_code && state_code

        c_code = country_code.to_s.upcase.to_sym
        s_code = state_code.to_s.upcase.to_sym
        states(c_code)[s_code]
      end

      def country_code_lookup(name)
        CS.countries.find { |code, cname| cname.downcase == name.downcase }&.first
      end

      def state_code_lookup(state_name, c_code)
        CS.states(c_code.to_sym).find { |scode, sname| sname.downcase == state_name.downcase }&.first
      end
    end
  end
end