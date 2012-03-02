# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "radiant-snippets-extension"

Gem::Specification.new do |s|
  s.name        = "radiant-snippets-extension"
  s.version     = RadiantSnippetsExtension::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = RadiantSnippetsExtension::AUTHORS
  s.email       = RadiantSnippetsExtension::EMAIL
  s.homepage    = RadiantSnippetsExtension::URL
  s.summary     = RadiantSnippetsExtension::SUMMARY
  s.description = RadiantSnippetsExtension::DESCRIPTION

  ignores = if File.exist?('.gitignore')
    File.read('.gitignore').split("\n").inject([]) {|a,p| a + Dir[p] }
  else
    []
  end
  s.files         = Dir['**/*'] - ignores
  s.test_files    = Dir['test/**/*','spec/**/*','features/**/*'] - ignores
  # s.executables   = Dir['bin/*'] - ignores
  s.require_paths = ["lib"]
end
