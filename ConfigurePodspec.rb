# Configures the given Podspec with shared constants for all RaModular podspecs.
def configure(spec:, name:, summary:, local_deps: [])
  # The shared CocoaPods version number for RaModular.
  #
  # Change this constant to increment the Podspec version for all RaModular Podspecs from a single place.
  version = '0.1.2'

  spec.name = name
  spec.summary = summary
  spec.version = version
  spec.license = 'MIT'
  spec.homepage = 'https://github.com/RakuyoKit/RaModular'
  spec.authors = 'Rakuyo'
  spec.source = { git: 'https://github.com/RakuyoKit/RaModular.git', tag: version }
  spec.source_files = "Sources/#{name}/**/*.swift"
  spec.ios.deployment_target = '11.0'
  spec.swift_versions = ['5.5']

  local_deps.each do |dep|
    spec.dependency dep, version
  end
end
