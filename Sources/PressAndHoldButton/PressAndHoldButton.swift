//
//  PressAndHoldButton.swift
//
//  Created by Louni Longheval on 18/02/2024.
//

import SwiftUI
import UIKit

/// `PressAndHoldButton` is a SwiftUI view that creates a button designed to respond to press-and-hold gestures.
/// The button visually fills up as the user presses and holds, and triggers an action when the press is held long enough.
///
/// ## Example Usage
/// ```
/// PressAndHoldButton(
///     text: "Press and Hold Me",
///     cornerRadius: 10,
///     backgroundColor: .blue,
///     isFullWidth: true,
///     width: 200, // Ignored if isFullWidth is true
///     height: 50,
///     onEnded: {
///         print("Button was held long enough!")
///     }
/// )
/// ```
/// - Parameters:
///   - text: The text to display on the button.
///   - cornerRadius: The corner radius of the button's rounded rectangle shape.
///   - backgroundColor: The background color of the button's fill as it progresses.
///   - isFullWidth: A Boolean value that determines if the button should stretch to the full width of its container.
///   - width: The width of the button if `isFullWidth` is `false`. Ignored if `isFullWidth` is `true`.
///   - height: The height of the button.
///   - onEnded: The action to perform when the button has been held down for the required duration.

struct PressAndHoldButton: View {

	let timerInterval = 0.01
	let requiredHoldDuration = 2.0
	@State private var progress: CGFloat = 0
	@State private var timer: Timer?
	@State private var buttonOpacity: Double = 1
	
	var text: String
	var cornerRadius: CGFloat
	var backgroundColor: Color
	var isFullWidth: Bool
	var width: CGFloat
	var height: CGFloat
	var onEnded: () -> Void
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: cornerRadius)
				.foregroundColor(.secondary.opacity(0.2))
				.if(isFullWidth, transform: { view in
					view.frame(maxWidth: .infinity)
				})
				.if(!isFullWidth, transform: { view in
					view.frame(width: width)
				})
				.frame(height: height)
				.overlay(
					GeometryReader { geometry in
						Rectangle()
							.foregroundColor(backgroundColor)
							.frame(width: geometry.size.width * progress, height: geometry.size.height)
							.clipped()
					}
				)
				.mask(
					RoundedRectangle(cornerRadius: cornerRadius)
				)
				.opacity(buttonOpacity)
			
			Text(text)
				.foregroundColor(.primary)
				.opacity(buttonOpacity)
		}
		.frame(height: height)
		.frame(maxWidth: .infinity)
		.cornerRadius(cornerRadius)
		.gesture(
			DragGesture(minimumDistance: 0)
				.onChanged({ _ in startFilling() })
				.onEnded({ _ in stopFilling() })
		)
		
	}
	
	/// Starts the fill-up process of the button and manages the haptic feedback based on the hold duration.
	///
	/// This function initializes a timer that increments the `progress` state to visualize the fill-up effect. It also manages the haptic feedback frequency to increase with the hold time, simulating an engine vibration effect. The filling and feedback continue until the `requiredHoldDuration` is met or the user releases the button.
	private func startFilling() {
		if progress == 0 {
			timer?.invalidate()
			
			let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
			feedbackGenerator.prepare()
			
			var lastFeedbackTime = Date()
			let initialFeedbackInterval = 0.2
			var currentFeedbackInterval = initialFeedbackInterval
			
			timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true) { [self] _ in
				
				if self.progress >= 1 {
					self.timer?.invalidate()
					self.onEnded()
					withAnimation(.easeOut(duration: 1)) {
						self.buttonOpacity = 0
					}
				} else {
					self.progress += CGFloat(self.timerInterval / self.requiredHoldDuration)
					let progressFactor = pow(2, self.progress * 1.5)
					currentFeedbackInterval = max(0.05, initialFeedbackInterval / progressFactor)
					if -lastFeedbackTime.timeIntervalSinceNow > currentFeedbackInterval {
						feedbackGenerator.impactOccurred()
						lastFeedbackTime = Date()
					}
				}
			}
		}
	}
	
	/// Stops the fill-up process and resets the button's visual progress if the hold was released before completion.
	///
	/// If the button was fully held down for the required duration, it executes the `onEnded` closure to perform the specified action. It also provides a success haptic feedback. If the button was released early, it resets the visual progress and stops any ongoing haptic feedback.
	private func stopFilling() {
		print("stopped")
		timer?.invalidate()
		if progress < 1 {
			withAnimation(.spring) {
				progress = 0
				buttonOpacity = 1
			}
		} else {
			let feedbackGenerator = UINotificationFeedbackGenerator()
			feedbackGenerator.notificationOccurred(.success)
		}
	}
}

extension View {
	/// Applies the given transform if the given condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			transform(self)
		} else {
			self
		}
	}
}
