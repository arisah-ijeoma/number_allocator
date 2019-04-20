# frozen_string_literal: true

class NumberGenerator
  def initialize
    @lower_limit = 1111111111
    @upper_limit = 9999999999
  end

  def generate_numbers(number)
    our_generated_number = (number || @lower_limit).to_i

    return 'invalid' if our_generated_number < @lower_limit || our_generated_number > @upper_limit

    if PhoneNumber.find_by_digits(our_generated_number)
      our_generated_number += 1
      return generate_numbers(our_generated_number)
    end
    PhoneNumber.create!(digits: our_generated_number)
    our_generated_number
  end

  def format_number(number = nil)
    x = generate_numbers(number)
    x.to_s.gsub(/^(\d{3})(\d+)(\d{4})$/, '\1-\2-\3')
  end
end
