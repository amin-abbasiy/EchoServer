require "rails_helper"

RSpec.describe Endpoint::Mock, :type => :service do
  describe "#page_title" do
    subject { described_class.new(self) }
    it " ... " do
      # subject.stub(:call).and_raise(JSON::ParserError)
      # expect(subject.call).to should(JSON::ParserError)
    end
    # }
  end
end