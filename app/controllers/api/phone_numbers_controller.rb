# frozen_String_literal: true

module Api
  class PhoneNumbersController < ApplicationController
    def generate_number
      value = params['value']
      generator = NumberGenerator.new

      render json: { phone_number: generator.format_number(value) }
    end
  end
end
