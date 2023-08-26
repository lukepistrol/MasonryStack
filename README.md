# MasonryStack

A Pinterest like layout in SwiftUI (horizontal & vertical).

https://github.com/lukepistrol/MasonryStack/assets/9460130/db3d0914-672d-4f53-8681-c28b8423994a

## Usage

> **Note**
> At this point this does not support lazy loading. Keep this in mind when displaying large amounts of data.

The `MasonryHStack` and `MasonryVStack` can be used just like `HStack` or `VStack`:

```swift
import SwiftUI
import MasonryStack

struct ContentView: View {
  var body: some View {
    MasonryVStack(columns: 2, spacing: 20) {
      // ...
    }
  }
}
```

Both stacks conform to the `Layout` protocol so you can easily switch between other layouts as well.


-----

<a href="https://www.buymeacoffee.com/lukeeep" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
