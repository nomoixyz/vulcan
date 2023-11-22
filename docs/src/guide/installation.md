# Installation

In an existing Foundry project, use `forge install`:

```
$ forge install nomoixyz/vulcan
```

Or install a specific release with:

```
$ forge install nomoixyz/vulcan@x.y.z
```

Release tags can be found [here](https://github.com/nomoixyz/vulcan/releases)

To reduce compatibility issues, `vulcan` utilizes a particular version of `forge-std`. To avoid such problems in your project, consider including the following in your remappings:

```
forge-std/=lib/vulcan/lib/forge-std/src/
vulcan/=lib/vulcan/src/
```
