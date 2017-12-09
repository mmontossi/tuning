$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'tuning/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'tuning'
  s.version     = Tuning::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['hi@museways.com']
  s.homepage    = 'https://github.com/museways/attachs'
  s.summary     = 'Tuning for rails.'
  s.description = 'Common tools used in rails extracted into a gem.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'

  s.add_development_dependency 'pg', '~> 0.21'
  s.add_development_dependency 'mocha', '~> 1.2'
end
