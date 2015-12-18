shared_examples "transition" do
  describe '#perform' do
    context 'when not guarded' do
      before do
        expect(subject).to receive(:before_transition)
        expect(subject).to receive(:transition)
        expect(subject).to receive(:after_transition)
      end

      specify 'that no errors are raised' do
        expect { subject.perform }.to_not raise_error
      end
    end

    context 'when guarded' do
      before do
        expect(subject).to receive(:can?).and_return(false)
        expect(subject).to_not receive(:before_transition)
        expect(subject).to_not receive(:transition)
        expect(subject).to_not receive(:after_transition)
      end

      specify 'that no errors are raised' do
        expect {
          subject.perform
        }.to raise_error(Transitor::TransitionError, Transitor::Base::GUARD_MESSAGE)
      end
    end
  end
end


