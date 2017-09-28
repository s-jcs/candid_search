require "active_support/concern"

require "candid_search/version"

module CandidSearch
  # ============================================================
  # Original code by: Justin Weiss
  # Code base from https://gist.github.com/justinweiss/9065666
  extend ActiveSupport::Concern

  module ClassMethods
    # NOTE: Call the class method with a hash containing named scope, and search
    #       key pairs. Always whitelist parameters before passing it to the method
    def filter(filtering_params)
      results = self.all # create an anonymous scope
      filtering_params.each do |key, value|
        next if value.blank?

        # NOTE: if name contains `_or_` merge two conditions.
        #       ex. Model.with_name_or_id
        results = if key.to_s.include?('_or_')
                    results.merge(results.public_send(key, value))
                  else
                    results.public_send(key, value)
                  end
      end
      results
    end
  end
end
