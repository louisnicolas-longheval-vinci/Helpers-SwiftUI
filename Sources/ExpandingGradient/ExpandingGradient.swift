//
//  ExpandingGradient.swift
//  ExpandingGradient
//
//  Created by Louni Longheval on 18/02/2024.
//

import SwiftUI


/// An `AnimatableModifier` that creates an expanding gradient effect.
/// The gradient transitions from transparent to a specified color set, animating from the bottom to the top of the view.
///
/// ## Example Usage:
/// ```
/// struct ContentView: View {
///     @State private var isAnimating = false
///
///     var body: some View {
///         // Apply the expanding gradient effect to a VStack.
///         VStack {
///             Text("Hello, World!")
///                 .padding()
///             Button("Toggle Animation") {
///                 isAnimating.toggle()
///             }
///         }
///         .expandingGradient(isAnimating: isAnimating)
///     }
/// }
/// ```
/// - Parameters:
///   - isAnimating: A Boolean value that triggers the animation when true.
///
struct ExpandingGradient: AnimatableModifier {
	var isAnimating: Bool
	
	/// Creates the body of the modifier.
	/// - Parameter content: The content view that the modifier is applied to.
	/// - Returns: A view with the applied expanding gradient effect.
	func body(content: Content) -> some View {
		GeometryReader { geometry in
			content
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(.regularMaterial)
				.background(
					ZStack {
						LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(isAnimating ? 0.7 : 0.0), Color.purple.opacity(isAnimating ? 0.7 : 0.0)]), startPoint: .bottom, endPoint: .top)
							.frame(height: geometry.size.height)
							.offset(y: isAnimating ? 0 : geometry.size.height)
							.ignoresSafeArea()
					}
				)
				.edgesIgnoringSafeArea(.all)
		}
	}
}

extension View {
	/// Applies an expanding gradient effect to the view.
	///
	/// This modifier wraps the content in a `GeometryReader` and applies a dynamic `LinearGradient` background. The gradient visibility and position are controlled by the `isAnimating` flag, creating an effect of the gradient expanding from the bottom to the top.
	///
	/// - Parameter isAnimating: A Boolean value that triggers the gradient animation. When `true`, the gradient expands from the bottom to the top of the view.
	///
	/// ## Example:
	/// ```
	/// struct ContentView: View {
	///     @State private var isAnimating = false
	///
	///     var body: some View {
	///         VStack {
	///             Text("Hello, World!")
	///                 .padding()
	///             Button("Toggle Animation") {
	///                 isAnimating.toggle()
	///             }
	///         }
	///         .expandingGradient(isAnimating: isAnimating)
	///     }
	/// }
	/// ```
	///
	/// - Returns: A view modified with an expanding gradient background effect.
	func expandingGradient(isAnimating: Bool) -> some View {
		self.modifier(ExpandingGradient(isAnimating: isAnimating))
	}
}
