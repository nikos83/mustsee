# frozen_string_literal: true

class NullOmdb
  def parsed_response
    { 'Error' => 'Something went wrong! Please find you log file for more details' }
  end
end
