# Configures the given Podspec with shared constants for all Services podspecs.
def configure(spec:, name:, local_deps: [])
  # The shared CocoaPods version number for Services.
  #
  # Change this constant to increment the Podspec version for all Services Podspecs from a single place.
  version = '0.1.0'

  spec.name = name
  spec.summary = 'summary'
  spec.license = 'MIT'
  spec.version = version
  spec.homepage = 'https://github.com/RakuyoKit/RaServices'
  spec.authors = 'Rakuyo'
  spec.source = { :path => '.' }
  spec.source_files = "Sources/*.swift"
  spec.ios.deployment_target = '13.0'
  spec.swift_versions = ['5.5']

  local_deps.each do |dep|
    spec.dependency dep, version
  end
end
