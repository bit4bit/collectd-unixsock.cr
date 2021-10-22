# collectd-unixsock


## TODO

- [X] PUTVAL
- [ ] GETVAL
- [ ] LISTVAL
- [ ] PUTNOTIF
- [ ] FLUSH

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     collectd-unixsock:
       github: bit4bit/collectd-unixsock.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "collectd-unixsock"

collectd = Collectd::Unixsock.open(socket_path)
status, message = collectd.putval("testval/cpu-0/cpu-idle",
  [Collectd::Unixsock::ValueListOption::CurrentTime, 2323])
  
collectd.close()
```

TODO: Write usage instructions here

## Development

1. See **Contributing**
2. Start docker environment with **make docker-setup**
3. Do changes and test with **make test**
3. Do changes and test with **make test-integration**

## Contributing

1. Fork it (<https://github.com/bit4bit/collectd-unixsock/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Jovany Leandro G.C](https://github.com/bit4bit) - creator and maintainer
