require 'spec_helper'

RSpec.describe Net::Http::Middleware do
  it 'has a version number' do
    expect(Net::Http::Middleware::VERSION).not_to be nil
  end
end
