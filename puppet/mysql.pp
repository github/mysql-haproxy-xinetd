class mysql (
) {

  ...

  class { '::xinetd': }

  ::services { 'mysqlchk_general':
    ensure       => present,
    service_name => 'mysqlchk_general',
    port         => 9876,
    protocol     => 'tcp',
  }

  file { '/etc/xinetd.d/mysqlchk_general':
    ensure => present,
    mode   => '0644',
    source => 'puppet:///modules/mysql/etc/xinetd.d/mysqlchk_general',
    notify => Service['xinetd'],
  }

  ...
}
