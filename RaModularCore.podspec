# pod lib lint RaModularCore.podspec --allow-warnings --skip-tests
# pod trunk push RaModularCore.podspec --allow-warnings --skip-tests --synchronous

Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModularCore',
    summary: 'The core tool of the modularization framework, which also provides the ability to access the app lifecycle within child components.')
end
