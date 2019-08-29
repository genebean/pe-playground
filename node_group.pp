node_group { 'Agent specified environment':
  ensure               => present,
  description          => 'Allows all nodes to pick their own environment',
  environment          => 'agent-specified',
  override_environment => true,
  parent               => 'All Environments',
  rule                 => ['and',  ['~', 'name', '.+']],
}
