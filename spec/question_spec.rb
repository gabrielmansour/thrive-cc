# frozen_string_literal: true

require_relative '../rules_engine'

RSpec.describe RulesEngine do
  subject { Question.new(attrs) }
  let(:attrs) do
    {
      "field_name": 'TechnicalBackground',
      "label": 'Is a technical background required?',
      "required": true,
      "field_type": 'select',
      "options": %w[
        Yes
        No
      ],
      "visibility_rules": {
        "$or": [
          { "RoleName": 'Fullstack Engineer' },
          { "RoleName": 'Product Manager', "PrimaryBusiness": 'Software development' }
        ]
      }
    }
  end

  describe 'basic attributes' do
    it 'is able to access attributes using dot notation' do
      expect(subject.field_name).to eq 'TechnicalBackground'
      expect(subject.options).to eq %w[Yes No]
    end
  end

  describe '#visible?' do
    let(:responses) { {} }
    context 'when there are no visibility_rules' do
      it 'does not call the RulesEngine' do
        expect(RulesEngine).to_not receive(:new)

        subject.visible?(responses)
      end

      it { is_expected.to be_visible(responses) }
    end

    context 'when there are visibility_rules' do
      before { attrs['visibility_rules'] = { '$or' => [{ 'Pie' => 'Apple' }] } }

      context 'when there are no other responses to compare to' do
        it 'does not call the RulesEngine' do
          expect(RulesEngine).to_not receive(:new)

          subject.visible?(responses)
        end

        it { is_expected.to be_visible(responses) }
      end

      context 'when there are other responses to compare to' do
        let(:responses) { { 'Question1' => 'Answer1' } }

        it 'calls the RulesEngine' do
          expect(RulesEngine).to receive(:new).with(attrs['visibility_rules'])
            .and_call_original

          subject.visible?(responses)
        end

        it { is_expected.to_not be_visible(responses) }
      end
    end
  end
end
