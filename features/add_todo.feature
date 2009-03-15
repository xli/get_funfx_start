Feature: Add todo into list

  Scenario: Add a new todo into list
    Given I am on todo list
    When I add a todo "Buy some cards for XP Game"
    Then I should see "Buy some cards for XP Game" in the todo list
