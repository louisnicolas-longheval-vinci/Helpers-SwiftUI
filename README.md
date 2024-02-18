
# Helpers

A collection of SwiftUI utility components designed to enhance your mobile applications with engaging UI effects and functionalities.

## Components

### ExpandingGradient

A SwiftUI modifier that creates a dynamic, animatable gradient effect. The gradient expands to fill the view, creating visually appealing transitions.

#### Example Usage:

```swift
struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        Text("Hello, World!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .expandingGradient(isAnimating: isAnimating)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 2)) {
                    isAnimating.toggle()
                }
            }
    }
}
```

### PressAndHoldButton

A custom SwiftUI button that fills up as the user presses and holds. Triggers an action when the press is held long enough, complete with haptic feedback to enhance user interaction.

#### Example Usage:

```swift
struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        PressAndHoldButton(
            text: "Press and Hold Me",
            cornerRadius: 10,
            backgroundColor: .blue,
            isFullWidth: true,
            width: 200, // Ignored if isFullWidth is true
            height: 50,
            onEnded: {
                print("Button was held long enough!")
            }
        )
    }
}
```

## Installation

`Helpers` is available as a Swift package. To include it in your project, add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourgithubusername/Helpers.git", .upToNextMajor(from: "1.0.0"))
]
```

Replace `"https://github.com/yourgithubusername/Helpers.git"` with the actual URL of your package repository.

## Requirements

- iOS 14.0+ / macOS 11+
- Swift 5.3+
- Xcode 12.0+

## Contributing

We welcome contributions and suggestions! Feel free to open an issue or submit a pull request.

## License

`Helpers` is available under the MIT license. See the LICENSE file for more info.
