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
Label("Wait gimme a sec") {
    ProgressView()
}
```
<img src="Resources/LabelIconView.png" width="375">

### Label with internal system image

Uses private `_internalSystemName:` for SF Symbols not publicly exposed:
```swift
Section {
    Label("1984", internalSystemName: "macintosh.classic")
    Label("2026", systemImage: "macbook.sizes")
    Label("Become a tester", internalSystemName: "apple.testflight")
    Label("Oh hello", internalSystemName: "emoji.face.winking.with.stuck.out.tongue")
}
```

<img src="Resources/LabelInternalImage.png" width="375">

### Label with UIImage or NSImage

Create labels directly from platform-native image instances:
```swift
// iOS, tvOS, watchOS, visionOS
let icon = UIImage(named: "custom-icon")!
Label("Custom Icon", uiImage: icon)

// macOS
let icon = NSImage(named: "custom-icon")!
Label("Custom Icon", nsImage: icon)
```

### LabeledContent with system image
```swift
Section {
    LabeledContent("Wi-Fi", systemImage: "wifi") {
        Text("Home Network")
    }

    LabeledContent("Bluetooth", internalSystemName: "bluetooth") {
        Text("On")
    }
}
```

<img src="Resources/LabeledContent.png" width="375">

### Tab with text-only labels

Available on iOS 18 and aligned releases (2024):
```swift
TabView {
    Tab("Home", value: .home) {
        HomeView()
    }
    
    Tab("Settings", value: .settings) {
        SettingsView()
    }
    
    Tab("About", value: .about) {
        AboutView()
    }
}
```

<img src="Resources/Tabs.png" width="375">

### System symbol availability checking

Check whether system symbols exist before using them, preventing runtime issues when symbols aren't available:

```swift
// Check public system symbols
if Image.systemSymbolExists("star.leadinghalf.filled") {
    Image(systemName: "star.leadinghalf.filled")
} else {
    Image(systemName: "star.fill")
}

// Check private system symbols
if Image.privateSymbolExists("macintosh.classic") {
    Image(_internalSystemName: "macintosh.classic")
} else {
    Image(systemName: "desktopcomputer")
}
```

> [!NOTE]
> Private symbols are not guaranteed to be available across OS versions and may change without notice. Use `privateSymbolExists(_:)` to safely check availability before using them.

### Static transform for compile-time conditions

Original code by [Julien Sagot](https://x.com/Barbapapapps/status/2002762692801737183/).

Apply different modifiers based on availability checks, compiler directives, or build configuration:
```swift
Button("Sign In") { }
.staticTransform { view in
    if #available(iOS 26.0, *) {
        view.buttonStyle(.glass)
    } else {
        view.buttonStyle(.bordered)
    }
}
```

> [!WARNING]
> `staticTransform` is designed exclusively for compile-time conditions. Do not use it as a general-purpose conditional modifier with runtime state (`@State`, `@Binding`, computed properties, etc.). Doing so will break view identity and cause performance issues. For runtime conditionals, prefer ternary operators (e.g., `.foregroundStyle(isActive ? .blue : .gray)`).
