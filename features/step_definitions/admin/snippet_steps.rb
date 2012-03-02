Given /^There are many snippets$/ do
  100.times do |i|
    Snippet.create(:name => "snippet_#{i}", :content => "This is snippet #{i}")
  end
end

Given /^There are few snippets$/ do
  #
end

Then /^I should see all the snippets$/ do
  Snippet.all.each do |snippet|
    response.body.should have_tag('tr.snippet') do
      with_tag("a", :text => snippet.name)
    end
  end
end

When /^I view a snippet$/ do
  visit "/admin/snippets/#{snippets(:first).id}"
end

When /^I view a filtered snippet$/ do
  visit "/admin/snippets/#{snippets(:markdown).id}"
end