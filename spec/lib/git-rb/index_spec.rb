require 'spec_helper'

RSpec.describe GitRb::Index do
  subject(:index) { described_class.new(path) }

  let(:path) { File.expand_path('../../../fixtures/index', __FILE__) }

  describe '#add' do
    pending 'Boo, write some test'
  end

  describe '#remove' do
    let(:initial_content) { index.content }

    it { expect { index.remove('foo.txt') }.to change { index.content }.from(initial_content).to('') }
  end

  describe '#match' do
    pending 'Boo, write some test'
  end

  describe '#entries' do
    pending 'Boo, write some test'
  end

  describe '#raw_paths' do
    pending 'Boo, write some test'
  end

  describe '#sha1s' do
    pending 'Boo, write some test'
  end

  describe '#object_paths' do
    pending 'Boo, write some test'
  end
end
