# frozen_string_literal: true

require_relative 'answer_set'

app = proc do |_env|
  data = JSON.parse(File.read('questions.json'))
  answer_set = AnswerSet.new.call(data)

  [200, { 'Content-Type' => 'text/plain' }, [JSON.pretty_generate(answer_set)]]
end

run app

# Automatically open server in browser, for convenience (for Mac OS X)
`open "http://localhost:7272"`
