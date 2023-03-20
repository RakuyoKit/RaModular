Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaServices',
    summary: 'RaServices',
    local_deps: ['RaServicesCore', 'RaServicesBehavior', 'RaServicesURLNavigate'])
end
