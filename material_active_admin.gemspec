$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'material_active_admin/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'material_active_admin'
  s.version     = MaterialActiveAdmin::VERSION
  s.authors     = ['Nelson Lee']
  s.email       = ['nelson@cleverbanana.com']
  s.homepage    = 'http://cleverbanana.com'
  s.summary     = 'add later: Summary of MaterialActiveAdmin.'
  s.description = 'add later: Description of MaterialActiveAdmin.'
  s.license     = 'MIT'

  s.files       = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files  = Dir['test/**/*']

  s.add_dependency 'rails', '>= 4.2.5'
  s.add_dependency 'slim-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'activeadmin', '~> 1.0.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails', '~> 5.0.5'
  s.add_dependency 'select2-rails'
  s.add_dependency 'tinymce-rails'
  s.add_dependency 'sprockets', '>= 3.0', '< 4.1'
  s.add_dependency 'sprockets-es6', '>= 0.9.2'

  s.add_development_dependency 'devise', '~> 4.2.0'
  s.add_development_dependency 'pg',     '~> 0.15'
  s.add_development_dependency 'thin'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'interactive_editor'
  s.add_development_dependency 'letter_opener'
  s.add_development_dependency 'awesome_print'
  s.add_development_dependency 'quiet_assets'
  s.add_development_dependency 'yard'
end
