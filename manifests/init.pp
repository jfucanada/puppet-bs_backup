define bs_backup (
  $config_class,
) {
  $current_time = strftime("%Y%m%d%H%M")
  
  exec { "${title}-pre":
    path    => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    command => "cp -f ${title} ${title}.last",
    unless  => "diff ${title} ${title}.last",
  }

  exec { "${title}-post":
    path    => ['/bin','/sbin','/usr/bin','/usr/sbin'],
    command => "mv ${title}.last ${title}.${current_time}.bak",
    unless  => "diff ${title} ${title}.last",
  }

  Exec["${title}-pre"] ->
  Class["$config_class"] ->
  Exec["${title}-post"]
}
