#
# xinetd daemon
#
class xinetd (
  $ensure      = running
) {
  package { 'xinetd':
    ensure  => present,
  }
  service { 'xinetd':
    ensure     => $ensure,
    enable     => true,
    hasrestart => true,
    restart    => '/usr/sbin/service xinetd restart',
    hasstatus  => true,
    status     => '/usr/sbin/service xinetd status',
    require    => Package['xinetd'],
  }
  file { '/etc/xinetd.conf':
    ensure => present,
    mode   => '0644',
    source => 'puppet:///modules/xinetd/etc/xinetd.conf',
    notify => Service['xinetd'],
  }
}
