Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModularBehavior',
    summary: 'RaModularBehavior',
    local_deps: ['RaModularCore'])
end