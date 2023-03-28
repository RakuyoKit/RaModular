# pod lib lint RaModularBehavior.podspec --allow-warnings --skip-tests
# pod trunk push RaModularBehavior.podspec --allow-warnings --skip-tests --synchronous

Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModularBehavior',
    summary: 'Provides the functionality of encapsulating common services in native code.',
    local_deps: ['RaModularCore'])
end
