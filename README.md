# SwiftUIHelpers

Convenience initializers for SwiftUI views that Apple should have shipped.

## Installation

Add SwiftUIHelpers to your project via Swift Package Manager:
```swift
dependencies: [
    .package(url: "https://github.com/samhenrigold/SwiftUIHelpers.git", from: "1.0.0")
]
```

## Usage

### Label with custom icon view
```swift
Label("Settings", icon: { 
    Image(systemName: "gear")
        .foregroundStyle(.blue)
})
```

### Label with internal system image

Uses private `_internalSystemName:` for SF Symbols not publicly exposed:
```swift
Label("Pro Features", internalSystemName: "star.leadinghalf.filled")
```

### LabeledContent with system image
```swift
LabeledContent("Storage", systemImage: "internaldrive") {
    Text("256 GB")
}
```

### Tab with text-only labels

Available on iOS 18+, macOS 15+:
```swift
TabView {
    Tab("Home", value: .home) {
        HomeView()
    }
    
    Tab("Settings", value: .settings) {
        SettingsView()
    }
}
```

## Requirements

- iOS 16+ / macOS 13+ / tvOS 16+ / watchOS 9+ / visionOS 1+
- Swift 6.2+
- Tab extensions require iOS 18+ / macOS 15+

## License

MIT
