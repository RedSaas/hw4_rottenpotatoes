require 'spec_helper'

describe MoviesController do
  describe 'Autotest' do
    it 'should search movies with same director' do
      get :same_director, {:id=>1} 
    end
  end

end
