Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModular',
    summary: 'RaModular',
    local_deps: ['RaModularCore', 'RaModularRouter', 'RaModularBehavior'])
end
