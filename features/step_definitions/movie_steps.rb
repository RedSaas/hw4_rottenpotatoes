# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.create!(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date])
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#  puts page.body
  e1_index=page.text.index(e1)
  e2_index=page.text.index(e2)
  if e1_index.nil? || e2_index.nil?
    assert false, "Cant Find string"
  else
    if e1_index<e2_index
      assert true, "Right order"
    else
      assert false, "Wrong order"
    end
  end
   
  
end

Then /I should see all of the movies/ do
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
#  page.all(:xpath, '//table[@id="movies"]').rows.should==11
  assert page.has_selector?("table tr", :count=>11)
  
#  assert false, "Unimplmemented"
end

Then /^the director of "(.*)" should be "(.*)"$/ do |arg1, arg2|
  arg1_index=page.text.index('Details about '+arg1)
  arg2_index=page.text.index(arg2)
  assert !(arg1_index.nil? || arg2_index.nil?), page.text
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

#When /I check '(.*)' checkbox/ do |checkbox|
#  check("ratings_#{checkbox}")
#end

#When /I uncheck '(.*)' checkbox/ do |checkbox|
#  uncheck("ratings_#{checkbox}")
#end

#Then /I should see movies only with ratings: (.*)/ do |ratings|
#  rating=ratings.split(%r{,\s*})
#  if !rating.nil?
#    page.all(:xpath, '//table[@id="movies"]//tr/td[2]').each do |cell|
#      if !rating.include?(cell.text)
#        assert false, "I see another movie"
#      end  
#    end
#  else 
#    assert false, "U didnt enter any rating"
#    
#  end
#  assert i_saw_movies, "U see films with ratings"
#end


#Then /I should see movies with ratings: (.*)/ do |ratings|
#  rating=ratings.split(%r{,\s*})
#  i_saw_movies=false
#  if !rating.nil?
#    page.all(:xpath, '//table[@id="movies"]//tr/td[2]').each do |cell|
#      if rating.include?(cell.text)
#        i_saw_movies=true
#      end  
#    end  
#  end
#  if !i_saw_movies
#    assert i_saw_movies, "U see films with ratings"
#  end
#end

#Then /I should not see movies with ratings: (.*)/ do |ratings|
#  rating=ratings.split(%r{,\s*})
#  i_saw_movies=true
#  if !rating.nil?
#    page.all(:xpath, '//table[@id="movies"]//tr/td[2]').each do |cell|
#      if rating.include?(cell.text)
#        i_saw_movies=false
#      end  
#    end
#  else
#    i_saw_movies=false
#  end
#  if !i_saw_movies
#    assert i_saw_movies, "U see another film"
#  end  
#end

#Then /I should see "(.*)"/ do |movie|
#  saw_movie=false
#  if !movie.nil?
#    page.all(:xpath, '//table[@id="movies"]//tr/td[1]').each do |cell|
#      if rating.include?(cell.text)
#       saw_movie=true
#        assert true
#      end  
#    end
#  else
#    assert false, "Empty movie title"
#  end
#  if !saw_movie
#  assert false, "I dont see movie #{movie} in list"
#  end
#end


#Then /I should not see "(.*)"/ do |movie|
#  if !movie.nil?
#    page.all(:xpath, '//table[@id="movies"]//tr/td[1]').each do |cell|
#      if rating.include?(cell.text)
#        assert false, "I saw movie - #{movie}"
#      end  
#    end
#  else
#    assert false, "Empty movie title"
#  end
#end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  check_box=(uncheck.nil?)
  rating_array=rating_list.delete("'").split(%r{,\s*})
  rating_array.each do |rating|
    if check_box
      check("ratings_#{rating}")
    else
      uncheck("ratings_#{rating}")
    end 
  end
end
