# pod lib lint RaModularRouter.podspec --allow-warnings --skip-tests
# pod trunk push RaModularRouter.podspec --allow-warnings --skip-tests --synchronous

Pod::Spec.new do |spec|
  # Update ConfigurePodspec.rb to increment the version number.
  require_relative 'ConfigurePodspec'
  configure(
    spec: spec,
    name: 'RaModularRouter',
    summary: 'Provides the ability to access view controllers through URLs.',
    local_deps: ['RaModularCore'])
end
