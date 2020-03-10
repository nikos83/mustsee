# frozen_string_literal: true

class NullOmdb
  def parsed_response
    { 'Title' => 'Error', 'Poster' => 'N/A', 'Plot' => 'Error' }
  end
end
