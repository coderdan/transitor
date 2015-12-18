shared_examples "transition common" do
  specify 'that the object is available as an accessor' do
    expect(subject.object).to eq(object)
  end

  describe '#raise_if_guarded!' do
    context 'when transition is allowed' do
      before { expect(subject).to receive(:can?).and_return(true) }

      specify 'that no error is raised' do
        expect { subject.raise_if_guarded! }.to_not raise_error
      end
    end

    context 'when transition is guarded' do
      before { expect(subject).to receive(:can?).and_return(false) }

      context 'with the default guard message' do
        specify 'that an error is raised with the default message' do
          expect {
            subject.raise_if_guarded!
          }.to raise_error(Transitor::TransitionError, Transitor::Base::GUARD_MESSAGE)
        end
      end

      context 'with a custom guard message' do
      before { expect(subject).to receive(:guarded_message).and_return('Custom message') }

        specify 'that an error is raised with the custom message' do
          expect {
            subject.raise_if_guarded!
          }.to raise_error(Transitor::TransitionError, 'Custom message')
        end
      end
    end
  end
end


