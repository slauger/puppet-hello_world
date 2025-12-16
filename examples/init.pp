# Example 1: Basic usage with defaults
# Creates /hello-world.txt with default message
include hello_world

# Example 2: Custom message and location
# class { 'hello_world':
#   message  => 'Greetings from the automation team!',
#   filepath => '/tmp/greetings.txt',
# }

# Example 3: Custom ownership and permissions
# class { 'hello_world':
#   message  => 'Hello Production Server!',
#   filepath => '/var/lib/hello.txt',
#   owner    => 'nobody',
#   group    => 'nogroup',
#   mode     => '0444',
# }

# Example 4: Remove the file
# class { 'hello_world':
#   ensure => absent,
# }
