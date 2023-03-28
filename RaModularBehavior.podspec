# sh pod_tools.sh lint|push RaModularBehavior

Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModularBehavior',
    summary: 'Provides the functionality of encapsulating common services in native code.',
    local_deps: ['RaModularCore'])
end
