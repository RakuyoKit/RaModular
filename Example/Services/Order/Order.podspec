Pod::Spec.new do |s|
  require_relative '../ConfigurePodspec'
  configure(
    spec: s,
    name: 'Order',
    local_deps: ['OrderInterface'])
end
