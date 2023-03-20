Pod::Spec.new do |s|
  require_relative '../ConfigurePodspec'
  configure(
    spec: s,
    name: 'OrderInterface',
    local_deps: ['RaServices'])
end
