# etcd
class etcd(
  $data_dir = $::etcd::params::data_dir,
  $config_dir = $::etcd::params::config_dir,
  $uid = $::etcd::params::uid,
  $gid = $::etcd::params::gid,
  $user = $::etcd::params::user,
  $group = $::etcd::params::group,
) inherits ::etcd::params {

  $nologin = $::osfamily ? {
    'RedHat' => '/sbin/nologin',
    'Debian' => '/usr/sbin/nologin',
    default  => '/usr/sbin/nologin',
  }

  group { $group:
    ensure => present,
    gid    => $gid,
  } ->
  user { $user:
    ensure => present,
    uid    => $uid,
    shell  => $nologin,
    home   => $data_dir,
  }

  file { $data_dir:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0750',
    require => User[$user],
  }

  file { $config_dir:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0750',
    require => User[$user],
  }
}
