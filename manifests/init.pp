# @summary
#   A simple Puppet module that creates a hello world file
#
# @example Basic usage
#   include hello_world
#
# @example Custom message and path
#   class { 'hello_world':
#     message  => 'Hello from Puppet!',
#     filepath => '/tmp/custom-hello.txt',
#     ensure   => present,
#   }
#
# @example Remove the file
#   class { 'hello_world':
#     ensure => absent,
#   }
#
# @param ensure
#   Whether the hello world file should be present or absent.
#   Valid values: 'present', 'absent'
#
# @param filepath
#   The absolute path where the hello world file should be created.
#   Default: '/hello-world.txt'
#
# @param message
#   The message to write to the hello world file.
#   Can include variables and multi-line text.
#   Default: A standard greeting message
#
# @param owner
#   The owner of the hello world file.
#   Default: 'root'
#
# @param group
#   The group of the hello world file.
#   Default: 'root'
#
# @param mode
#   The file permissions in octal notation.
#   Default: '0644'
#
class hello_world (
  Enum['present', 'absent'] $ensure='present',
  Stdlib::Absolutepath $filepath='/hello-world.txt',
  String $message='Hello World from Puppet!',
  String $owner='root',
  String $group='root',
  String $mode='0644',
  ) {
  # Validate that we have a message when ensure is present
  if $ensure == 'present' and empty($message) {
    fail('Parameter message cannot be empty when ensure is present')
  }

  # Create or remove the hello world file
  file { $filepath:
  ensure  => $ensure,
  owner   => $owner,
  group   => $group,
  mode    => $mode,
  content => epp('hello_world/hello_world.epp', {
    'message'   => $message,
    'timestamp' => strftime('%Y-%m-%d %H:%M:%S'),
    'hostname'  => $facts['networking']['fqdn'],
  }),
  }

  # Optional: notify when the file is managed
  if $ensure == 'present' {
    notify { "hello_world_created_${filepath}":
      message => "Hello World file created at ${filepath}",
    }
  }
}
