require 'spec_helper'

RSpec.describe GitRb::Repository do

  subject { described_class }

  describe '.init' do

    context 'when not initialized' do

      before { allow(subject).to receive(:init?).and_return(false) }

      it do
        expect(subject).to receive(:do_init).once
        subject.init('')
      end

    end

    context 'when already initialized' do

      before { allow(subject).to receive(:init?).and_return(true) }

      it do
        expect(subject).to receive(:do_reinit).once
        subject.init('')
      end

    end

  end

end
