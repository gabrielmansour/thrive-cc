# frozen_string_literal: true

require_relative '../answer_set'

RSpec.describe AnswerSet do
  describe '#call' do
    let(:questions) { JSON.parse(File.read('questions.json')) }
    let(:answers) do
      [
        {
          'RoleName' => 'Customer Success',
          'PrimaryBusiness' => 'Accounting'
        },
        {
          'RoleName' => 'Customer Success',
          'PrimaryBusiness' => 'Software development'
        },
        {
          'RoleName' => 'Customer Success',
          'PrimaryBusiness' => 'Landscaping'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Accounting',
          'TechnicalBackground' => 'Yes'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Accounting',
          'TechnicalBackground' => 'No'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Software development',
          'TechnicalBackground' => 'Yes'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Software development',
          'TechnicalBackground' => 'No'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Landscaping',
          'TechnicalBackground' => 'Yes'
        },
        {
          'RoleName' => 'Fullstack Engineer',
          'PrimaryBusiness' => 'Landscaping',
          'TechnicalBackground' => 'No'
        },

        {
          'RoleName' => 'Product Manager',
          'PrimaryBusiness' => 'Accounting'
        },
        {
          'RoleName' => 'Product Manager',
          'PrimaryBusiness' => 'Software development',
          'TechnicalBackground' => 'Yes'
        },
        {
          'RoleName' => 'Product Manager',
          'PrimaryBusiness' => 'Software development',
          'TechnicalBackground' => 'No'
        },
        {
          'RoleName' => 'Product Manager',
          'PrimaryBusiness' => 'Landscaping'
        }
      ]
    end

    it 'generates correct number of answer combinations' do
      expect(subject.call(questions).size).to eq answers.size
    end

    it 'generates all possible valid answer combinations' do
      expect(subject.call(questions)).to match_array answers
    end

    context 'when questions are empty' do
      let(:questions) { [] }

      it 'returns an empty array' do
        expect(subject.call(questions)).to eq []
      end
    end
  end
end
