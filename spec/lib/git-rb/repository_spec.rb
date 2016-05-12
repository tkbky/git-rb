require 'spec_helper'

RSpec.describe GitRb::Repository do

  subject(:repository) { described_class }

  describe '.init' do

    subject(:init) { repository.init(dir, config) }

    let(:dir) { 'foo' }
    let(:config) { instance_double(GitRb::Config) }

    context 'when initialize a bare repository' do

      before { allow(config).to receive(:bare).and_return(true) }

      context 'when not initialized' do

        before { allow(repository).to receive(:init?).and_return(false) }

        it do
          expect(repository).to receive(:init_bare).once
          init
        end

      end

      context 'when already initialized' do

        before { allow(repository).to receive(:init?).and_return(true) }

        pending 'Not implemented'

      end

    end

    context 'when initialize a repository' do

      before { allow(config).to receive(:bare).and_return(false) }

      context 'when not initialized' do

        before { allow(repository).to receive(:init?).and_return(false) }

        it do
          expect(repository).to receive(:init_common).once
          init
        end

      end

      context 'when already initialized' do

        before { allow(repository).to receive(:init?).and_return(true) }

        pending 'Not implemented'

      end

    end

  end

end
