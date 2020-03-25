class profile::java_deployment (
  Optional[Stdlib::HTTPUrl]      $url          = undef,
  String                         $path         = $name,
  Enum['present', 'absent']      $ensure       = present,
  Optional[String]               $owner        = undef,
  Optional[String]               $group        = undef,
  Optional[String]               $mode         = undef,
  Optional[Boolean]              $extract      = undef,
  Optional[String]               $extract_path = undef,
  Optional[String]               $creates      = undef,
  Optional[Boolean]              $cleanup      = undef,
  Optional[Stdlib::Absolutepath] $archive_path = undef,
) {
  archive { $file_path:
    ensure        => $ensure,
    path          => $file_path,
    extract       => true,
    extract_path  => '/tmp',
    source        => $file_url,
    checksum      => $sha1,
    checksum_type => 'sha1',
    creates       => $creates,
    cleanup       => $cleanup,
  }
}
