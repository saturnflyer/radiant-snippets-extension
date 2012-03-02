When /^I view a snippet$/ do
  visit "/admin/snippets/#{snippets(:first).id}"
end

When /^I view a filtered snippet$/ do
  visit "/admin/snippets/#{snippets(:markdown).id}"
end