# frozen_string_literal: true

require 'rails_helper'

describe 'generator', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json" } }
  let(:parsed_body) { JSON.parse(response.body) }

  it 'returns value on request without number' do
    get '/api/generate_number', headers: headers
    expect(response).to have_http_status(200)
    expect(parsed_body['phone_number']).to eq('111-111-1111')
  end

  it 'returns value when I request it if available' do
    get '/api/generate_number/1234567890', headers: headers
    expect(parsed_body['phone_number']).to eq('123-456-7890')
  end

  it 'does not return a number already allotted' do
    get '/api/generate_number/1234567890', headers: headers
    expect(parsed_body['phone_number']).to eq('123-456-7890')

    get '/api/generate_number/1234567890', headers: headers
    parsed_body = JSON.parse(response.body)
    expect(parsed_body['phone_number']).not_to eq('123-456-7890')
    expect(parsed_body['phone_number']).to eq('123-456-7891')
  end

  it 'returns an error for invalid numbers' do
    get '/api/generate_number/123456', headers: headers
    expect(parsed_body['phone_number']).to eq('invalid')
  end
end
