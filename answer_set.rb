# frozen_string_literal: true

require_relative 'question'
require 'json'

class AnswerSet
  def call(questions)
    questions = questions.map { |q| Question.new(q) }

    generate_answers(questions)
  end

  private

  def generate_answers(questions, previous_responses = {})
    return [] if questions.empty?

    q = questions.first
    responses = build_responses(previous_responses, q)

    return responses if questions.one?

    responses.flat_map do |response_set|
      generate_answers(questions[1..-1], response_set)
    end
  end

  def build_responses(other_responses, question)
    return other_responses unless question.visible?(other_responses)

    question.options.map do |option|
      other_responses.merge(question.field_name => option)
    end
  end
end
