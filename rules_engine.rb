# frozen_string_literal: true

class RulesEngine
  def initialize(rules)
    @rules = rules
  end

  def visible?(other_responses)
    return true unless @rules&.any?

    @rules['$or'].any? { |condition_hash| other_responses >= condition_hash }
  end
end
