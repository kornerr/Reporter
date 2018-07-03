# Overview

`Reporter` allows you to broadcast changes to any number of subscribers.
Think of Reporter as multidelegate implementation.

# Features

- [x] Report (broadcast) to any number of subscribers
- [x] React to a report (broadcast) with a Swift closure
- [x] Control subscription lifetime with `ReporterBag`

# Requirements

- Xcode 9.0+
- Swift 4.0+

# Installation

Simply add `Reporter.swift` (~150 lines of code) file to your Xcode project.

# Sample application

`Reporter` is particularly useful when implementing Controllers/Services or
other entities with dynamic data changed over time.

Sample application demonstrates a case of user profile loading.

## Preview

This is what the app looks like:

![Preview][preview]

## Reporter usage


---

## Why come up with this?

TODO

Separation of concerns, etc.

How SwiftReporter solves this.

---

## Usage

### Reporting / subscription / bag

```swift
import SwiftReporter
...
```

## Alternatives

TODO

## Issues

TODO

Create issue and we'll sort it out together.

# License

Reporter is released under the ZLIB license.

[preview]: preview.gif

