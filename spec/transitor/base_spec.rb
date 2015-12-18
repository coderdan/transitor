require 'spec_helper'

RSpec.describe Transitor::Base do
  subject { described_class.new(object) }

  context 'when the object is a PORO' do
    let(:object) { double(:object) }
    include_examples "transition common"
    include_examples "transition"
  end

  context 'when the object is an Active Record' do
    let(:object) { Person.new }

    include_examples "transition"
    include_examples "transition common"

    context 'and the transaction block is yielded' do
      before { expect(ActiveRecord::Base).to receive(:transaction).and_yield }
      include_examples "transition"
    end

    context 'and the transaction block is not yielded (verifies that calls are made with in transaction)' do
      before { expect(ActiveRecord::Base).to receive(:transaction) }

      specify 'that nothing happens!' do
        expect(subject).to_not receive(:before_transition)
        expect(subject).to_not receive(:transition)
        expect(subject).to_not receive(:after_transition)
        subject.perform
      end
    end
  end
end
