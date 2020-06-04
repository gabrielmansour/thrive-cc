# frozen_string_literal: true

require 'ostruct'
require_relative 'rules_engine'

class Question < OpenStruct
  def visible?(other_responses)
    # short circuit so that we don't unnecessarily allocate additional
    # objects in memory:
    return true if visibility_rules.nil? || other_responses.empty?

    rules_engine.visible?(other_responses)
  end

  private

  def rules_engine
    @rules_engine ||= RulesEngine.new(visibility_rules)
  end
end
