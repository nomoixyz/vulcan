# Semver

## Structs

### Semver

```solidity
struct Semver {
	uint256 major
	uint256 minor
	uint256 patch
}
```



## semver



### **create(uint256 major, uint256 minor, uint256 patch) &rarr; (Semver)**



### **create(uint256 major, uint256 minor) &rarr; (Semver)**



### **create(uint256 major) &rarr; (Semver)**



### **parse(string input) &rarr; (Semver)**



### **toString(Semver self) &rarr; (string)**



### **equals(Semver self, Semver other) &rarr; (bool)**



### **greaterThan(Semver self, Semver other) &rarr; (bool)**



### **greaterThanOrEqual(Semver self, Semver other) &rarr; (bool)**



### **lessThan(Semver self, Semver other) &rarr; (bool)**



### **lessThanOrEqual(Semver self, Semver other) &rarr; (bool)**



