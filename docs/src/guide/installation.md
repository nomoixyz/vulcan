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

In order to minimize compatibility issues, `vulcan` uses a specific version of `forge-std`. To
prevent these issues in your project you can add this to your remappings:

```
forge-std/=lib/vulcan/lib/forge-std/src/
vulcan/=lib/vulcan/src/
```
