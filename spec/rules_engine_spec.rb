# frozen_string_literal: true

require_relative '../rules_engine'

RSpec.describe RulesEngine do
  subject { RulesEngine.new(rules) }
  let(:other_responses) do
    { 'RoleName' => 'Product Manager', 'PrimaryBusiness' => 'Software development' }
  end

  context 'when there are no rules' do
    let(:rules) { nil }
    it { is_expected.to be_visible(other_responses) }
  end

  context 'when there is an empty ruleset' do
    let(:rules) { {} }
    it { is_expected.to be_visible(other_responses) }
  end

  context 'when there are rules' do
    let(:rules) do
      {
        '$or' => [
          { 'RoleName' => 'Fullstack Engineer' },
          { 'RoleName' => 'Product Manager', 'PrimaryBusiness' => 'Software development' }
        ]
      }
    end

    context 'when at least one of the rules in the $or array matches' do
      it { is_expected.to be_visible(other_responses) }
    end

    context 'when it matches a rule in the $or array that contains a single condition' do
      let(:other_responses) do
        { 'RoleName' => 'Fullstack Engineer', 'PrimaryBusiness' => 'Landscaping' }
      end

      it { is_expected.to be_visible(other_responses) }
    end

    context 'when it matches a rule in the $or array that contains multiple conditions' do
      it { is_expected.to be_visible(other_responses) }
    end

    context 'when none of the conditions in the $or array match the responses' do
      let(:other_responses) do
        { 'RoleName' => 'Product Manager', 'PrimaryBusiness' => 'Accounting' }
      end
      it { is_expected.to_not be_visible(other_responses) }
    end
  end
end
