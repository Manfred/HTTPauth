Gem::Specification.new do |spec|
  spec.name      = 'httpauth'
  spec.version   = '0.2.0'

  spec.author   = "Manfred Stienstra"
  spec.email    = "manfred@fngtpspec.com"
  spec.homepage = "https://github.com/Manfred/HTTPauth"

  spec.summary = "HTTPauth is a library supporting the full HTTP Authentication protocol as specified in RFC 2617; both Digest Authentication and Basic Authentication."
  spec.description = "Library for the HTTP Authentication protocol (RFC 2617)"

  spec.files = %w(README.md LICENSE) + Dir.glob("lib/**/*")

  spec.add_development_dependency "bundler", "~> 1.0"

  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README.md", "LICENSE"]
  spec.rdoc_options << "--charset=utf-8"
end
