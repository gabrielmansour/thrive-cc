# frozen_string_literal: true

class RulesEngine
  def initialize(rules)
    @rules = rules
  end

  def visible?(other_responses)
    return true unless @rules&.any?

    @rules['$or'].each do |condition_hash|
      return true if other_responses >= condition_hash
    end

    false
  end
end
