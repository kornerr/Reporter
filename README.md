# Overview

`Reporter` allows you to broadcast changes to any number of subscribers.
Think of `Reporter` as multidelegate implementation.

`Reporter` is particularly useful when implementing Controllers/Services or
other entities with dynamic data changed over time.

# Features

- [x] Report (broadcast) to any number of subscribers
- [x] React to a report (broadcast) with a Swift closure
- [x] Control subscription lifetime with `ReporterBag`

# Requirements

- Xcode 9.0+
- Swift 4.0+

# Installation

Simply add `Reporter.swift` (~150 lines of code) file to your Xcode project.

# Usage

Suppose you have `ProfileController` entity that provides the following user
information (incapsulated into `ProfileItem` structure):

* user name
* user image

`ProfileController` keeps `ProfileItem` in one of the following three discrete states:

* no user information is available
    * `ProfileItem` is nil
* user information is available, however, user image has to be loaded
    * `ProfileItem` exists
    * `Profileitem.username` exists
    * `ProfileItem.image` is nil
* user information is available and image has been loaded
    * `ProfileItem` exists
    * both `ProfileItem.username` and `ProfileItem.image' exist

As you can see, `ProfileController`'s `ProfileItem` is dynamic and changes
over time. `Reporter` helps you subscribe to these changes and keep your
view with the latest data available.

Here's how the example syncs `ProfileVC` display with `ProfileController`
data:

```
self.profileController.itemChanged.subscribe { [weak self] in
    guard
        let this = self,
        let item = this.profileController.item
    else
    {
        return
    }
    this.profileVC.item = item
}
```

Now it doesn't matter who or what initiates `ProfileItem` updates. `ProfileVC`
is never out of sync with the data.

# Example

Sample application (in `example/` directory) demonstrates a case of user profile loading.

## Preview

![Preview][preview]

## Architecture

Here's a brief overview of files under `example/App/Profile` (in the order of importance):

* ProfileCoordinator
    *
* ProfileController
    *
* ProfileItem
    *
* ProfileVC
    *


## Reporter usage

TODO sample code

# License

Reporter is released under the ZLIB license.

[preview]: preview.gif

