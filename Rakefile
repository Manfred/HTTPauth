require 'rake'
require 'rake/clean'
require 'rake/testtask'
require 'rake/gempackagetask'
require 'rake/rdoctask'

NAME = 'httpauth'
VERSIE = '0.2' 
RDOC_OPTS = ['--quiet', '--title', "HTTPAuth - A Ruby library for creating, parsing and validating HTTP authentication headers",
    "--opname", "index.html",
    "--line-numbers", 
    "--main", "README",
    "--charset", "utf-8",
    "--inline-source"]
CLEAN.include ['pkg', 'doc', '*.gem']

desc 'Default: run tests'
task :default => [:test]
task :package => [:clean]

desc 'Run tests'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = true
end

desc 'Create documentation'
Rake::RDocTask.new("doc") do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.options += RDOC_OPTS
  rdoc.main = "README"
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Upload rdoc documentation to Rubyforge'
task :upload_doc => :doc do
  `scp -r #{File.dirname(__FILE__)}/doc/* mst@rubyforge.org:/var/www/gforge-projects/httpauth/`
end

spec =
    Gem::Specification.new do |s|
        s.name = NAME
        s.version = VERSIE
        s.platform = Gem::Platform::RUBY
        s.has_rdoc = true
        s.extra_rdoc_files = ["README", "LICENSE"]
        s.rdoc_options += RDOC_OPTS + ['--exclude', '^(examples|test)\/']
        s.summary = "Library for the HTTP Authentication protocol (RFC 2617)"
        s.description = "HTTPauth is a library supporting the full HTTP Authentication protocol as specified in RFC 2617; both Digest Authentication and Basic Authentication."
        s.author = "Manfred Stienstra"
        s.email = 'manfred@fngtps.com'
        s.homepage = 'http://httpauth.rubyforge.org'
        s.required_ruby_version = '>= 1.8.0'

        s.files = %w(README LICENSE Rakefile) +
          Dir.glob("lib/**/*") + 
          Dir.glob("examples/**/*")
        
        s.require_path = "lib"
    end

Rake::GemPackageTask.new(spec) do |p|
    p.need_tar = true
    p.gem_spec = spec
end

task :install do
  sh %{rake package}
  sh %{sudo gem install pkg/#{NAME}-#{VERSIE}}
end

task :uninstall => [:clean] do
  sh %{sudo gem uninstall #{NAME}}
end
