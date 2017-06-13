# frozen_string_literal: true

require_relative './spec_helper'

describe Exchange do
  it 'version' do
    _(Exchange::VERSION).must_equal '0.1.0'
  end
end
