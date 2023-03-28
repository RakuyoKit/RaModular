# pod lib lint RaModular.podspec --allow-warnings --skip-tests
# pod trunk push RaModular.podspec --allow-warnings --skip-tests

Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModular',
    summary: 'A Swift modularization framework that provides the functionality of accessing view controllers through URLs and encapsulating common services in native code.',
    local_deps: ['RaModularCore', 'RaModularRouter', 'RaModularBehavior'])
end
