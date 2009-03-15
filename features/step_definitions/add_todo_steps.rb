
Given 'I am on todo list' do
end

When /Type "(.*)" into input field/ do |todo|
  @flex.text_input(:id => 'todo').input(todo)
end

When /Click "(.*)" botton/ do |label|
  @flex.button(:automationName => label).click
end

When /I add a todo "(.*)"/ do |todo|
  When %{Type #{todo.inspect} into input field}
  When %{Click "Add" botton}
end

Then /I should see "(.*)" in the todo list/ do |todo|
  data = @flex.data_grid(:id => 'list')
  list = data.values(0, 1)
  list.should == [[todo]]
end
