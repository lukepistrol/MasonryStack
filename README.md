# MasonryStack

A Pinterest like layout in SwiftUI (horizontal & vertical).

https://github.com/lukepistrol/MasonryStack/assets/9460130/db3d0914-672d-4f53-8681-c28b8423994a

## Usage

The `MasonryHStack` and `MasonryVStack` can be used just like `HStack` or `VStack`:

```swift
var body: some View {
  MasonryVStack(columns: 2, spacing: 20) {
    // ...
  }
}
```

Both stacks conform to the `Layout` protocol so you can easily switch between other layouts as well.
