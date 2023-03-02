# Watchers

#### **`watcherAddress(address target) → (address)`**

Obtains the address of the watcher for `target`.

#### **`targetAddress(address _watcher) → (address)`**

Obtains the address of the target for `_target`.

#### **`watcher(address target) → (Watcher)`**

Obtains the Watcher implementation for the `target` address.

#### **`watch(address target) → (Watcher)`**

Starts watching a `target` address.

#### **`stop(address target)`**

Stops watching the `target` address.

#### **`stopWatcher(address target)`**

Stops watching the `target` address.

#### **`calls(address target) → (Call[] )`**

Obtains all the calls made to the `target` address.

#### **`getCall(address target, uint256 index) → (Call )`**

Obtains an specific call made to the `target` address at an specific index.

#### **`firstCall(address target) → (Call )`**

Obtains the first call made to the `target` address.

#### **`lastCall(address target) → (Call )`**

Obtains the last call made to the `target` address.

#### **`captureReverts(address target) → (Watcher)`**

Starts capturing reverts for the `target` address. This will prevent the `target` contract to
revert until `disableCaptureReverts` is called. This is meant to be used in conjunction with the `toHaveReverted` and
`toHaveRevertedWith` functions from the expect library.

#### **`disableCaptureReverts(address target) → (Watcher)`**

Stops capturing reverts for the `target` address.

