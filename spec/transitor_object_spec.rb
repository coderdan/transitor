require 'spec_helper'

RSpec.describe Campaign do
  describe '#submit!' do
    context 'when the transition is allowed' do
      let(:campaign) { Campaign.new }

      specify 'that the transition is applied' do
        expect { campaign.submit! }.to change { campaign.state }.from(:draft).to(:submitted)
      end

      describe 'transition life cycle' do
        subject(:history) { campaign.history }
        before { campaign.submit! }
        it { is_expected.to eq([:before, :transition, :after]) }
      end
    end

    context 'when the transition is guarded' do
      let(:campaign) { Campaign.new(:submitted) }

      specify 'that an error is raised' do
        expect {
          campaign.submit!
        }.to raise_error(Transitor::TransitionError, "Already Submitted")
      end

      describe 'transition life cycle' do
        subject(:history) { campaign.history }

        before do
          begin
            campaign.submit!
          rescue
          end
        end

        it { is_expected.to be_empty }
      end
    end
  end
end
