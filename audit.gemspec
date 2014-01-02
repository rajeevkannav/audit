$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "audit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "audit"
  s.version = Audit::VERSION
  s.authors = ["Rajeev Kannav Sharma"]
  s.email = ["rajeev@headerlabs.com"]
  s.homepage = "https://github.com/"
  s.summary = "Summary of Audit."
  s.description = <<-eos
  Audit a simple rails mountable engine/ ruby gem.
  1. It Tracks each and every activity of you rails application to a Different Database (sQlite).
  2. It create a new db via a Rake Task Or a defined limit say 2 lacs by default.
  3. It backup old db to Archive.
  4. All the Previous data can be seen at any time.
  5.
  eos

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
  s.add_development_dependency "sqlite3"
end
