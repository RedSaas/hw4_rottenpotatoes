require 'spec_helper'


describe MoviesController do
  describe 'Autotest' do
    include MoviesHelper
    
    it 'should oddenes' do
      oddness(4) 
    end
    it 'should destroy' do
      @movies=mock_model(Movie, :id=>1)
      Movie.stub!(:find).and_return(@movies)
      get :destroy, {:id=>1} 
    end
    it 'should edit' do
      @movies=mock_model(Movie, :id=>1)
      Movie.stub!(:find).and_return(@movies)
      get :edit, {:id=>1} 
    end
    it 'should update' do
      @movies=mock_model(Movie, :id=>1, :title=>'None')
      Movie.stub!(:find).and_return(@movies)
      @movies.stub!(:update_attributes!).with({"title"=>"New Movie title"})
      put :update, {:id=>1, :movie=>{:title=>"New Movie title"}}
    end
    it 'should create' do
      @movies=mock_model(Movie)
      @movies.stub!(:create!).with({"title"=>"New Movie title"})
      post :create, {:movie=>{:title=>"New Movie title"}}
    end
    it 'should show' do
      @movies=mock_model(Movie, :id=>1)
      Movie.stub!(:find).and_return(@movies)
      get :show, {:id=>1} 
    end
    it 'should on home page sort by title' do
      @movies=mock_model(Movie)
      Movie.stub!(:find).and_return(@movies)
      get :index, {:sort=>'title', "ratings[G]"=>1}
    end
    it 'should on home page sort by date' do
      @movies=mock_model(Movie)
      Movie.stub!(:find).and_return(@movies)
      get :index, {:sort=>'release_date'}
    end
    it 'should on home page filter with rating G' do
      @movies=mock_model(Movie)
      Movie.stub!(:find).and_return(@movies)
      get :index, {:ratings=>{:G=>1}}
    end
    it 'should on home page' do
      @movies=mock_model(Movie)
      Movie.stub!(:find).and_return(@movies)
      get :index
    end
    it 'should search similar movies with empty director' do
      @movies=mock_model(Movie, :id=>1, :title=>'Dzh uda4i', :director=>'')
      Movie.stub!(:find_by_id).and_return(@movies)
      get :same_director, {:id=>1} 
    end

    it 'should search similar movies' do
      @movies=mock_model(Movie, :id=>1, :title=>'Dzh uda4i', :director=>'Gaydar')
      Movie.stub!(:find_by_id).and_return(@movies)
      get :same_director, {:id=>1} 
    end
  end

end
