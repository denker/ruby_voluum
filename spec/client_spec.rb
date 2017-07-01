RSpec.describe RubyVoluum::Client do
  let(:client) do
    VCR.use_cassette('login_with_email') do
      RubyVoluum::Client.new(email: 'good@good.com', password: '12345678')
    end
  end

  describe '#initialize' do
    context 'accepts' do
      it 'email&password' do
        expect { client }.not_to raise_error
      end

      xit 'access_key' do
        expect { RubyVoluum::Client.new(access_key: 'asdf') }.not_to raise_error
      end

      context 'when no access_key or email&password provided' do
        it { expect { RubyVoluum::Client.new }.to raise_error ArgumentError }
      end
    end

    context 'for email and password' do
      context 'valid' do
        it 'returns a RubyVoluum::Client instance' do
          expect(client).to be_instance_of RubyVoluum::Client
        end

        it 'returned object responds to #token' do
          expect(client).to respond_to(:token)
        end
      end

      context 'invalid' do
        subject do
          VCR.use_cassette('login_with_bad_email') do
            RubyVoluum::Client.new(email: 'bad@bad.com', password: 'badbadbad')
          end
        end

        it 'raises NotAuthorizedError' do
          expect { subject }.to raise_error RubyVoluum::Exceptions::NotAuthorizedError
        end
      end
    end

    context 'for access_key' do
      context 'valid' do
        it 'returns a RubyVoluum::Client instance'
        it 'returned object responds to #token'
      end

      context 'invalid' do
        it 'raises NotAuthorizedError'
      end
    end
  end

  describe '#report' do
    subject { client.report }

    it 'returns a RubyVoluum::Report collection' do
      expect(subject).to be_instance_of RubyVoluum::Report
    end
  end
end
