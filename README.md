# hosts.cr

hosts for [Crystal](http://crystal-lang.org/).

- crystal: 0.20.4

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  hosts:
    github: maiha/hosts.cr
    version: 0.1.0
```

## API

```
Hosts.new
Hosts#[](key)  : Hosts::Host
Hosts#[]?(key) : Hosts::Host?
```

## Usage

```crystal
require "hosts"

hosts = Hosts.new
hosts["192.168.0.1"]       # => Hosts::Host
hosts["192.168.0.1"].names # => Set{"host1", "ubuntu"}
hosts["192.168.1.1"]?      # => nil

hosts["host1"]             # => Hosts::Host
hosts["host1"].addr        # => "192.168.0.1"
hosts["host_xxx"]?         # => nil
```

## Contributing

1. Fork it ( https://github.com/maiha/hosts.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
