#
# @summary Manage Redis implementation.
#
# @example Hiera example for managing Redis
#   profile::redis::bind: 127.0.0.1
#
# @param bind Variant[Stdlib::IP::Address, Array[Stdlib::IP::Address]]
#   Configure which IP address(es) to listen on. To bind on all interfaces, use an empty array.
# @param activerehashing Optional[Boolean] $activerehashing
#   Enable/disable active rehashing.
# @param aof_load_truncated Optional[Boolean]
#   Enable/disable loading truncated AOF file.
# @param aof_rewrite_incremental_fsync Optional[Boolean]
#   Enable/disable fsync for AOF file.
# @param appendfilename Optional[String[1]]
#   The name of the append-only file.
# @param appendfsync Optional[Enum['no', 'always', 'everysec']]
#   Adjust fsync mode.
# @param appendonly Optional[Boolean]
#   Enable/disable append-only mode.
# @param auto_aof_rewrite_min_size Optional[String[1]]
#   Adjust minimum size for auto-aof-rewrite
# @param auto_aof_rewrite_percentage Optional[Integer[0]]
#   Adjust percentatge for auto-aof-rewrite
# @param databases Optional[Integer[1]] 
#   Set the number of databases.
# @param default_install Optional[Boolean]
#   Configure a default install of redis.
# @param dbfilename Optional[Variant[String[1], Boolean]]
#   The filename where to dump the DB.
# @param hash_max_ziplist_entries Optional[Integer[0]]
#   Set max ziplist entries for hashes.
# @param hash_max_ziplist_value Optional[Integer[0]]
#   Set max ziplist values for hashes.
# @param hll_sparse_max_bytes Optional[Integer[0]]
#   HyperLogLog sparse representation bytes limit
# @param hz Optional[Integer[1, 500]]
#   Set redis background tasks frequency.
# @param latency_monitor_threshold Optional[Integer[0]]
#   Latency monitoring threshold in milliseconds.
# @param list_max_ziplist_entries Optional[Integer[0]]
#   Set max ziplist entries for lists.
# @param list_max_ziplist_value Optional[Integer[0]]
#   Set max ziplist values for lists.
# @param manage_package Optional[Boolean]
#   Enable/disable management of package.
# @param manage_repo Optional[Boolean]
#   Enable/disable upstream repository configuration.
# @param maxclients Optional[Integer[1]]
#  Set the max number of connected clients at the same time.
# @param min_slaves_max_lag Optional[Integer[0]]
#   The lag in seconds.
# @param min_slaves_to_write Optional[Integer[0]]
#   Minimum number of slaves to be in "online" state.
# @param no_appendfsync_on_rewrite Optional[Boolean]
#   If you have latency problems turn this to 'true'. Otherwise leave it as-is.
# @param notify_service Optional[Boolean]
#   You may disable service reloads when config files change.
# @param managed_by_cluster_manager Optional[Boolean]
#   Choose if redis will be managed by a cluster manager such as pacemaker or rgmanager
# @param package_ensure Optional[String[1]]
#   Default action for package.
# @param protected_mode Optional[Boolean]
#   Whether protected mode is enabled or not.  Only applicable when no bind is set.
# @param rdbcompression Optional[Boolean]
#   Enable/disable compression of string objects using LZF when dumping.
# @param repl_backlog_size Optional[String[1]]
#   Replication backlog size.
# @param repl_backlog_ttl Optional[Integer[0]]
#   Number of seconds to elapse before freeing backlog buffer
# @param repl_disable_tcp_nodelay Optional[Boolean]
#   Enable/disable TCP_NODELAY on the slave socket after SYNC
# @param repl_ping_slave_period Optional[Integer[1]]
#   Slaves send PINGs to server in a predefined interval.
# @param repl_timeout Optional[Integer[1]]
#   Set replication timeout.
# @param save_db_to_disk Optional[Boolean]
#   Set if save db to disk.
# @param save_db_to_disk_interval Optional[Hash]
#   Save the dataset every N seconds if there are at least M changes in the dataset
# @param service_enable Optional[Boolean]
#   Enable/disable daemon at boot.
# @param service_group Optional[String[1]]
#   Specify which group to run as.
# @param service_hasrestart Optional[Boolean]
#   Does the init script support restart?
# @param service_hasstatus Optional[Boolean]
#   Does the init script support status?
# @param service_manage Optional[Boolean]
#   Specify if the service should be part of the catalog.
# @param service_user Optional[String[1]]
#   Specify which user to run as.
# @param set_max_intset_entries Optional[Integer[0]]
#   Sets the limit in the size memory-saving encoding.
# @param slave_priority Optional[Integer[0]]
#   The priority number for slave promotion by Sentinel.
# @param slave_read_only Optional[Boolean]
#   You can configure a slave instance to accept writes or not.
# @param slave_serve_stale_data Optional[Boolean]
#   When a slave loses its connection with the master, or when the replication
#   is still in progress, the slave can act in two different ways:
#   1) if slave-serve-stale-data is set to 'yes' (the default) the slave will
#      still reply to client requests, possibly with out of date data, or the
#      data set may just be empty if this is the first synchronization.
#   2) if slave-serve-stale-data is set to 'no' the slave will reply with
#      an error "SYNC with master in progress" to all the kind of commands
#      but to INFO and SLAVEOF.
# @param slowlog_log_slower_than Optional[Integer[0]]
#   Tells Redis what is the execution time, in microseconds, to exceed in order
#   for the command to get logged.
# @param slowlog_max_len Optional[Integer[0]]
#   Tells Redis what is the length to exceed in order for the command to get
#   logged.
# @param stop_writes_on_bgsave_error Optional[Boolean]
#   If false then Redis will continue to work as usual even if there are
#   problems with disk, permissions, and so forth.   
# @param syslog_enabled Optional[Boolean]
#   Enable/disable logging to the system logger.
# @param tcp_backlog Optional[Integer[0]]
#   Sets the TCP backlog
# @param tcp_keepalive Optional[Integer[0]]
#   TCP keepalive.
# @param timeout Optional[Integer[0]]
#   Close the connection after a client is idle for N seconds (0 to disable).
# @param unixsocket Optional[Variant[Stdlib::Absolutepath, Enum['']]]
#   Define unix socket path.
# @param unixsocketperm Optional[Variant[Stdlib::Filemode, Enum['']]]
#   Define unix socket file permissions.
# @param ulimit Optional[Integer[0]]
#   Limit the use of system-wide resources.
# @param zset_max_ziplist_entries Optional[Integer[0]]
#   Set max entries for sorted sets.
# @param zset_max_ziplist_value Optional[Integer[0]]
#   Set max values for sorted sets.
# @param cluster_enabled Optional[Boolean]
#   Enables redis 3.0 cluster functionality
# @param cluster_config_file Optional[String[1]]
#   Config file for saving cluster nodes configuration. This file is never
#   touched by humans. Only set if cluster_enabled is true   
# @param cluster_node_timeout Optional[Integer[1]]
#   Node timeout. Only set if cluster_enabled is true   
# @param cluster_slave_validity_factor Optional[Integer[0]]
#   Control variable to disable promoting slave in case of disconnection from master
#   Only set if cluster_enabled is true
# @param cluster_require_full_coverage Optional[Boolean]
#   If false Redis Cluster will server queries even if requests about a subset of keys can be processed
#   Only set if cluster_enabled is true
# @param cluster_migration_barrier Optional[Integer[0]]
#   Minimum number of slaves master will remain connected with, for another
#   slave to migrate to a master which is no longer covered by any slave.
#   Only set if cluster_enabled is true
# @param instances Optional[Hash[String[1], Hash]]
#   Iterate through multiple instance configurations

class profile::redis (
  Variant[Stdlib::IP::Address, Array[Stdlib::IP::Address]] $bind                   = ['127.0.0.1]',
  Optional[Boolean]                                 $activerehashing               = undef,
  Optional[Boolean]                                 $aof_load_truncated            = undef,
  Optional[Boolean]                                 $aof_rewrite_incremental_fsync = undef,
  Optional[String[1]]                               $appendfilename                = undef,
  Optional[Enum['no', 'always', 'everysec']]        $appendfsync                   = undef,
  Optional[Boolean]                                 $appendonly                    = undef,
  Optional[String[1]]                               $auto_aof_rewrite_min_size     = undef,
  Optional[Integer[0]]                              $auto_aof_rewrite_percentage   = undef,
  Optional[Integer[1]]                              $databases                     = undef,
  Optional[Boolean]                                 $default_install               = undef,
  Optional[Variant[String[1], Boolean]]             $dbfilename                    = undef,
  Optional[Integer[0]]                              $hash_max_ziplist_entries      = undef,
  Optional[Integer[0]]                              $hash_max_ziplist_value        = undef,
  Optional[Integer[0]]                              $hll_sparse_max_bytes          = undef,
  Optional[Integer[1, 500]]                         $hz                            = undef,
  Optional[Integer[0]]                              $latency_monitor_threshold     = undef,
  Optional[Integer[0]]                              $list_max_ziplist_entries      = undef,
  Optional[Integer[0]]                              $list_max_ziplist_value        = undef,
  Optional[Boolean]                                 $manage_package                = undef,
  Optional[Boolean]                                 $manage_repo                   = undef,
  Optional[Integer[1]]                              $maxclients                    = undef,
  Optional[Integer[0]]                              $min_slaves_max_lag            = undef,
  Optional[Integer[0]]                              $min_slaves_to_write           = undef,
  Optional[Boolean]                                 $no_appendfsync_on_rewrite     = undef,
  Optional[Boolean]                                 $notify_service                = undef,
  Optional[Boolean]                                 $managed_by_cluster_manager    = undef,
  Optional[String[1]]                               $package_ensure                = undef,
  Optional[Boolean]                                 $protected_mode                = undef,
  Optional[Boolean]                                 $rdbcompression                = undef,
  Optional[String[1]]                               $repl_backlog_size             = undef,
  Optional[Integer[0]]                              $repl_backlog_ttl              = undef,
  Optional[Boolean]                                 $repl_disable_tcp_nodelay      = undef,
  Optional[Integer[1]]                              $repl_ping_slave_period        = undef,
  Optional[Integer[1]]                              $repl_timeout                  = undef,
  Optional[Boolean]                                 $save_db_to_disk               = undef,
  Optional[Hash]                                    $save_db_to_disk_interval      = undef,
  Optional[Boolean]                                 $service_enable                = undef,
  Optional[String[1]]                               $service_group                 = undef,
  Optional[Boolean]                                 $service_hasrestart            = undef,
  Optional[Boolean]                                 $service_hasstatus             = undef,
  Optional[Boolean]                                 $service_manage                = undef,
  Optional[String[1]]                               $service_user                  = undef,
  Optional[Integer[0]]                              $set_max_intset_entries        = undef,
  Optional[Integer[0]]                              $slave_priority                = undef,
  Optional[Boolean]                                 $slave_read_only               = undef,
  Optional[Boolean]                                 $slave_serve_stale_data        = undef,
  Optional[Integer[0]]                              $slowlog_log_slower_than       = undef,
  Optional[Integer[0]]                              $slowlog_max_len               = undef,
  Optional[Boolean]                                 $stop_writes_on_bgsave_error   = undef,
  Optional[Boolean]                                 $syslog_enabled                = undef,
  Optional[Integer[0]]                              $tcp_backlog                   = undef,
  Optional[Integer[0]]                              $tcp_keepalive                 = undef,
  Optional[Integer[0]]                              $timeout                       = undef,
  Optional[Variant[Stdlib::Absolutepath, Enum['']]] $unixsocket                    = undef,
  Optional[Variant[Stdlib::Filemode, Enum['']]]     $unixsocketperm                = undef,
  Optional[Integer[0]]                              $ulimit                        = undef,
  Optional[Integer[0]]                              $zset_max_ziplist_entries      = undef,
  Optional[Integer[0]]                              $zset_max_ziplist_value        = undef,
  Optional[Boolean]                                 $cluster_enabled               = undef,
  Optional[String[1]]                               $cluster_config_file           = undef,
  Optional[Integer[1]]                              $cluster_node_timeout          = undef,
  Optional[Integer[0]]                              $cluster_slave_validity_factor = undef,
  Optional[Boolean]                                 $cluster_require_full_coverage = undef,
  Optional[Integer[0]]                              $cluster_migration_barrier     = undef,
  Optional[Hash[String[1], Hash]]                   $instances                     = undef,
) {

  require ::profile

  class { '::redis':
    bind                          => $bind,
    activerehashing               => $activerehashing,
    aof_load_truncated            => $aof_load_truncated,
    aof_rewrite_incremental_fsync => $aof_rewrite_incremental_fsync,
    appendfilename                => $appendfilename,
    appendfsync                   => $appendfsync,
    appendonly                    => $appendonly,
    auto_aof_rewrite_min_size     => $auto_aof_rewrite_min_size,
    auto_aof_rewrite_percentage   => $auto_aof_rewrite_percentage,
    databases                     => $databases,
    default_install               => $default_install,
    dbfilename                    => $dbfilename,
    hash_max_ziplist_entries      => $hash_max_ziplist_entries,
    hash_max_ziplist_value        => $hash_max_ziplist_value,
    hll_sparse_max_bytes          => $hll_sparse_max_bytes,
    hz                            => $hz,
    latency_monitor_threshold     => $latency_monitor_threshold,
    list_max_ziplist_entries      => $list_max_ziplist_entries,
    list_max_ziplist_value        => $list_max_ziplist_value,
    manage_package                => $manage_package,
    manage_repo                   => $manage_repo,
    maxclients                    => $maxclients,
    min_slaves_max_lag            => $min_slaves_max_lag,
    min_slaves_to_write           => $min_slaves_to_write,
    no_appendfsync_on_rewrite     => $no_appendfsync_on_rewrite,
    notify_service                => $notify_service,
    managed_by_cluster_manager    => $managed_by_cluster_manager,
    package_ensure                => $package_ensure,
    protected_mode                => $protected_mode,
    rdbcompression                => $rdbcompression,
    repl_backlog_size             => $repl_backlog_size,
    repl_backlog_ttl              => $repl_backlog_ttl,
    repl_disable_tcp_nodelay      => $repl_disable_tcp_nodelay,
    repl_ping_slave_period        => $repl_ping_slave_period,
    repl_timeout                  => $repl_timeout,
    save_db_to_disk               => $save_db_to_disk,
    save_db_to_disk_interval      => $save_db_to_disk_interval,
    service_enable                => $service_enable,
    service_group                 => $service_group,
    service_hasrestart            => $service_hasrestart,
    service_hasstatus             => $service_hasstatus,
    service_manage                => $service_manage,
    service_user                  => $service_user,
    set_max_intset_entries        => $set_max_intset_entries,
    slave_priority                => $slave_priority,
    slave_read_only               => $slave_read_only,
    slave_serve_stale_data        => $slave_serve_stale_data,
    slowlog_log_slower_than       => $slowlog_log_slower_than,
    slowlog_max_len               => $slowlog_max_len,
    stop_writes_on_bgsave_error   => $stop_writes_on_bgsave_error,
    syslog_enabled                => $syslog_enabled,
    tcp_backlog                   => $tcp_backlog,
    tcp_keepalive                 => $tcp_keepalive,
    timeout                       => $timeout,
    unixsocket                    => $unixsocket,
    unixsocketperm                => $unixsocketperm,
    ulimit                        => $ulimit,
    zset_max_ziplist_entries      => $zset_max_ziplist_entries,
    zset_max_ziplist_value        => $zset_max_ziplist_value,
    cluster_enabled               => $cluster_enabled,
    cluster_config_file           => $cluster_config_file,
    cluster_node_timeout          => $cluster_node_timeout,
    cluster_slave_validity_factor => $cluster_slave_validity_factor,
    cluster_require_full_coverage => $cluster_require_full_coverage,
    cluster_migration_barrier     => $cluster_migration_barrier,
    instances                     => $instances,
  }
}
