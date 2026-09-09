require_relative 'lib/moon_stack/version'

Gem::Specification.new do |spec|
  spec.name = 'moon-stack'
  spec.version = MoonStack::VERSION
  spec.authors = ['tsuki']
  spec.summary = 'A small Ruby web stack starter'
  spec.description = 'Moon Stack generates a minimal Sinatra-based Ruby web app.'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.2'
  spec.files = Dir[
    'bin/*',
    'lib/**/*',
    'templates/**/*',
    'templates/**/.*',
    'README.md',
    'LICENSE'
  ].reject { |path| File.directory?(path) }
  spec.bindir = 'bin'
  spec.executables = ['moon']
  spec.require_paths = ['lib']
end
