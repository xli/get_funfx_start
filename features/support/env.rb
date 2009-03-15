# features/support/env.rb

require 'rubygems'
require 'spec'
require 'fileutils'
require 'funfx/browser/safariwatir'

BROWSER = Watir::Safari.new

# FunFX.fire_pause = 1

Before do
  BROWSER.goto(File.expand_path(File.dirname(__FILE__) + "/../../dist/todo.html"))
  @flex = BROWSER.flex_app('todolist', 'todolist')
end

After do
  # BROWSER.close if ENV['CIBUILD']
end
