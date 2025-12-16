# hello_world

A simple Puppet module that creates a hello world file on managed nodes.

## Table of Contents

1. [Description](#description)
2. [Setup](#setup)
3. [Usage](#usage)
4. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)

## Description

This module demonstrates basic Puppet module structure and functionality. It creates a customizable hello world text file on managed nodes with configurable content, location, ownership, and permissions.

Perfect for:
- Learning Puppet module development
- Testing Puppet deployments
- Demonstrating CI/CD pipelines for Puppet modules
- Quick smoke tests of Puppet agent functionality

## Setup

### Requirements

- Puppet >= 6.0.0
- puppetlabs/stdlib >= 4.25.0

### Installing the module

Install from source:

```bash
git clone https://github.com/slauger/puppet-hello_world.git
puppet module install ./puppet-hello_world
```

Or use in your Puppetfile:

```ruby
mod 'hello_world',
  :git => 'https://github.com/slauger/puppet-hello_world.git',
  :tag => 'v1.0.0'
```

## Usage

### Basic usage

Include the class with default parameters to create `/hello-world.txt`:

```puppet
include hello_world
```

This creates a file at `/hello-world.txt` with a default greeting message.

### Custom message and location

```puppet
class { 'hello_world':
  message  => 'Greetings from the automation team!',
  filepath => '/tmp/greetings.txt',
}
```

### Custom ownership and permissions

```puppet
class { 'hello_world':
  message  => 'Hello Production Server!',
  filepath => '/var/lib/hello.txt',
  owner    => 'nobody',
  group    => 'nogroup',
  mode     => '0444',
}
```

### Using with Hiera

In your Hiera data:

```yaml
---
classes:
  - hello_world

hello_world::message: 'Hello from Hiera!'
hello_world::filepath: '/opt/hello.txt'
hello_world::mode: '0640'
```

### Removing the file

```puppet
class { 'hello_world':
  ensure => absent,
}
```

## Reference

### Class: `hello_world`

Main class that manages the hello world file.

#### Parameters

##### `ensure`

Data type: `Enum['present', 'absent']`

Whether the hello world file should be present or absent.

Default: `'present'`

##### `filepath`

Data type: `Stdlib::Absolutepath`

The absolute path where the hello world file should be created.

Default: `'/hello-world.txt'`

##### `message`

Data type: `String`

The message to write to the hello world file. Can include variables and multi-line text.

Default: `'Hello World from Puppet!'`

##### `owner`

Data type: `String`

The owner of the hello world file.

Default: `'root'`

##### `group`

Data type: `String`

The group of the hello world file.

Default: `'root'`

##### `mode`

Data type: `String`

The file permissions in octal notation.

Default: `'0644'`

## Limitations

This module is compatible with:
- RedHat/CentOS 7, 8, 9
- Debian 10, 11, 12
- Ubuntu 20.04, 22.04, 24.04

Other operating systems may work but are not officially tested.

## Development

This module uses semantic versioning and follows Conventional Commits for automated releases.

### Contributing

1. Fork the repository
2. Create a feature branch from `develop`
3. Make your changes with conventional commit messages
4. Submit a pull request to `develop`

### Commit Message Format

This project uses Conventional Commits:

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build/tooling changes

Examples:
```
feat(init): add support for custom file templates
fix(init): correct file permissions validation
docs(readme): update installation instructions
```

### Release Process

Releases are automated via semantic-release when changes are merged to `main`:

1. Develop in `develop` branch
2. Create PR to `develop`
3. Merge `develop` to `main` when ready for release
4. semantic-release automatically:
   - Determines version bump
   - Updates metadata.json
   - Generates CHANGELOG.md
   - Creates GitHub release
   - Tags the release

## License

Apache License 2.0

## Authors

- slauger
