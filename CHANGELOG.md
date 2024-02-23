# Changelog

## [0.4.7](https://github.com/nomoixyz/vulcan/compare/v0.4.6...v0.4.7) (2024-02-23)


### Features

* install forge-std@v1.7.6 ([6a102f5](https://github.com/nomoixyz/vulcan/commit/6a102f5f99c11f923e70cf40be1c70dc50953cb9))
* string to json ([#238](https://github.com/nomoixyz/vulcan/issues/238)) ([f67740f](https://github.com/nomoixyz/vulcan/commit/f67740f8a9c846a543aebf29433ad69c3f0ff337))
* update forge-std ([#240](https://github.com/nomoixyz/vulcan/issues/240)) ([943b0d3](https://github.com/nomoixyz/vulcan/commit/943b0d33b0111caf18fae3594f1ca89e925bac58))

## [0.4.6](https://github.com/nomoixyz/vulcan/compare/v0.4.5...v0.4.6) (2023-11-27)


### Features

* rpc module ([#236](https://github.com/nomoixyz/vulcan/issues/236)) ([d02a2ac](https://github.com/nomoixyz/vulcan/commit/d02a2ac5cb8bf3d64e014d8a55ab2f475712c65b))
* update forge-std to v1.7.3 ([95ce186](https://github.com/nomoixyz/vulcan/commit/95ce1863037a91a7c8db5f9d631ecc625243f4c9))

## [0.4.5](https://github.com/nomoixyz/vulcan/compare/v0.4.4...v0.4.5) (2023-11-07)


### Features

* add message to expect utilities ([#231](https://github.com/nomoixyz/vulcan/issues/231)) ([7e0754a](https://github.com/nomoixyz/vulcan/commit/7e0754a8c6e5e21852895d5dd5981b4a794f0b9b))

## [0.4.4](https://github.com/nomoixyz/vulcan/compare/v0.4.3...v0.4.4) (2023-11-07)


### Bug Fixes

* fix file exists ([#228](https://github.com/nomoixyz/vulcan/issues/228)) ([c02feb1](https://github.com/nomoixyz/vulcan/commit/c02feb19aa34449376f52805663414aefafdc06a))

## [0.4.3](https://github.com/nomoixyz/vulcan/compare/v0.4.2...v0.4.3) (2023-10-26)


### Features

* new project structure ([#220](https://github.com/nomoixyz/vulcan/issues/220)) ([2d45c4c](https://github.com/nomoixyz/vulcan/commit/2d45c4c9b5072f218514997e6e656d3c2a10262e))


### Bug Fixes

* fix cast abi-encode command ([#226](https://github.com/nomoixyz/vulcan/issues/226)) ([b340aaf](https://github.com/nomoixyz/vulcan/commit/b340aafad4b2efcdb4d0c983ee6d02c79c1c1dea))

## [0.4.2](https://github.com/nomoixyz/vulcan/compare/v0.4.1...v0.4.2) (2023-10-10)


### Bug Fixes

* update forge-std ([#214](https://github.com/nomoixyz/vulcan/issues/214)) ([8e3fb60](https://github.com/nomoixyz/vulcan/commit/8e3fb600b34b8ece7e2ff43b2f59ce01919ad611))

## [0.4.1](https://github.com/nomoixyz/vulcan/compare/v0.4.0...v0.4.1) (2023-10-03)


### Bug Fixes

* add missing imports on script.sol ([#212](https://github.com/nomoixyz/vulcan/issues/212)) ([294c9d9](https://github.com/nomoixyz/vulcan/commit/294c9d9079b8d0045bbe2b33e7021665c6e0fe53))
* use forge@v1.6.1 ([#210](https://github.com/nomoixyz/vulcan/issues/210)) ([bda8bf0](https://github.com/nomoixyz/vulcan/commit/bda8bf0df6daf609ec03bae7ebbaed099438a396))

## [0.4.0](https://github.com/nomoixyz/vulcan/compare/v0.3.1...v0.4.0) (2023-10-02)


### ⚠ BREAKING CHANGES

* use results on fs module ([#191](https://github.com/nomoixyz/vulcan/issues/191))
* use custom types for Results and Error, and use error functions ([#189](https://github.com/nomoixyz/vulcan/issues/189))
* remove Results from json setters ([#182](https://github.com/nomoixyz/vulcan/issues/182))
* add results to commands ([#179](https://github.com/nomoixyz/vulcan/issues/179))

### Features

* add basic types to pointer casting ([#198](https://github.com/nomoixyz/vulcan/issues/198)) ([5f96f7b](https://github.com/nomoixyz/vulcan/commit/5f96f7b254c12684e579666a7a05f8bce7a3afce))
* add results to commands ([#179](https://github.com/nomoixyz/vulcan/issues/179)) ([9770c9e](https://github.com/nomoixyz/vulcan/commit/9770c9ef2f58c638a4d25c33487cee5bf11ce103))
* add semver module ([#204](https://github.com/nomoixyz/vulcan/issues/204)) ([b4a687b](https://github.com/nomoixyz/vulcan/commit/b4a687b1fd2d6d355e11bf4581ef1cc7fb2bec27))
* improved json validation using Results ([#178](https://github.com/nomoixyz/vulcan/issues/178)) ([50b1d14](https://github.com/nomoixyz/vulcan/commit/50b1d14439866ac1cf76a4be959b5631184c88aa))
* remove Results from json setters ([#182](https://github.com/nomoixyz/vulcan/issues/182)) ([6a601ae](https://github.com/nomoixyz/vulcan/commit/6a601ae623a3aa6c84b42270636c2d46ef630ba6))
* request module ([#174](https://github.com/nomoixyz/vulcan/issues/174)) ([63b58b4](https://github.com/nomoixyz/vulcan/commit/63b58b4803d50ad62e131ba344046bb054adb52f))
* use `serializeJson` cheatcode ([#196](https://github.com/nomoixyz/vulcan/issues/196)) ([6a90b1b](https://github.com/nomoixyz/vulcan/commit/6a90b1bea3a14b87c59ddf8edc2721d463b43d22))
* use custom types for Results and Error, and use error functions ([#189](https://github.com/nomoixyz/vulcan/issues/189)) ([4e69e1c](https://github.com/nomoixyz/vulcan/commit/4e69e1cd7f9beadcfead37fafc0d0ea5ee37599f))
* use forge-std@705263c ([#195](https://github.com/nomoixyz/vulcan/issues/195)) ([392d99e](https://github.com/nomoixyz/vulcan/commit/392d99e4525c642cae1da577e274326fcefa4de2))
* use results on fs module ([#191](https://github.com/nomoixyz/vulcan/issues/191)) ([f2998a1](https://github.com/nomoixyz/vulcan/commit/f2998a1821132d9fbb8fda8ef807de61d6dc0bf3))

## [0.3.1](https://github.com/nomoixyz/vulcan/compare/v0.3.0...v0.3.1) (2023-09-01)


### Bug Fixes

* adapt to new forge-std Vm to remove warnings ([e83ebd4](https://github.com/nomoixyz/vulcan/commit/e83ebd403e1e46d3cbf684343e967478bf0a8e29))

## [0.3.0](https://github.com/nomoixyz/vulcan/compare/v0.2.0...v0.3.0) (2023-09-01)


### Features

* add function to create empty command ([2c31886](https://github.com/nomoixyz/vulcan/commit/2c31886075fae5a5177410739309ff38ed834f2a))
* export Command struct from script.sol ([c88883a](https://github.com/nomoixyz/vulcan/commit/c88883a402ccfae6aa2d0de674936ba22e3d3514))


### Bug Fixes

* fix return natspect documentation ([5da4ad1](https://github.com/nomoixyz/vulcan/commit/5da4ad14fbe07b35d29260fe2cb97ffb2cb95de3))
* tabs ([1d4c0b9](https://github.com/nomoixyz/vulcan/commit/1d4c0b9d350445825d84198c7b242f5e432ffb39))
* update code examples ([953d661](https://github.com/nomoixyz/vulcan/commit/953d661e1a84e84b9a40b8f8178980ea32d0ef96))
