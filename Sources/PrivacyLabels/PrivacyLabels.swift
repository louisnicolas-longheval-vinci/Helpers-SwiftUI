//
//  SwiftUIView.swift
//  
//
//  Created by Louni Longheval on 05/03/2024.
//

import SwiftUI

/// `ReusablePrivacyView` is a SwiftUI view designed to display privacy-related information in a clear and customizable manner. It supports displaying a main icon with a title, reasons for privacy practices, and detailed usage information.
///
/// This component allows for flexibility by accepting various text and image inputs, making it reusable in different contexts within an app, especially for displaying privacy policies or information handling practices.
///
/// ## Example Usage
/// ```
/// ReusablePrivacyView(
///     mainTitle: "IBAN Privacy",
///     mainIcon: "hand.raised",
///     reasonTitle: "Why We Need Your IBAN",
///     reasonItems: [
///         "Send your IBAN to friends",
///         "Get your friends' IBAN"
///     ],
///     usageTitle: "How Your IBAN Is Used",
///     usageDescription: "Your IBAN is used only for transactions within the app. It is shared with your consent."
/// )
/// ```
/// - Parameters:
///   - mainTitle: The main title displayed at the top of the view.
///   - mainIcon: The SF Symbol name for the icon displayed near the main title.
///   - reasonTitle: The title for the reasons section.
///   - reasonItems: An array of strings detailing individual reasons or practices.
///   - usageTitle: The title for the usage section.
///   - usageDescription: Detailed text explaining how the information is used.

struct ReusablePrivacyView: View {
	@Environment(\.dismiss) private var dismiss
	@Environment(\.colorScheme) var colorScheme
	
	let mainTitle: String
	let mainIcon: String
	let reasonTitle: String
	let reasonItems: [String]
	let usageTitle: String
	let usageDescription: String
	
	var body: some View {
		NavigationStack {
			VStack {
				VStack {
					Image(systemName: mainIcon)
						.symbolVariant(.circle.fill)
						.font(.system(size: 60))
					Text(mainTitle)
						.font(.largeTitle)
						.bold()
						.padding(.top, 5)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding()
				
				Divider()
					.frame(height: 3)
					.overlay(Color.primary)
					.cornerRadius(5)
				
				VStack(alignment: .leading, spacing: 10) {
					Text(reasonTitle)
						.font(.title2)
						.bold()
					
					ForEach(reasonItems, id: \.self) { item in
						HStack {
							Image(systemName: "checkmark")
								.font(.headline)
							Text(item)
								.font(.headline)
						}
					}
				}
				.padding()
				
				Divider()
					.frame(height: 3)
					.overlay(Color.primary)
					.cornerRadius(5)
				
				VStack(alignment: .leading, spacing: 10) {
					Text(usageTitle)
						.font(.title2)
						.bold()
					Text(usageDescription)
						.font(.headline)
				}
				.padding()
			}
			.frame(maxWidth: .infinity)
			.toolbar {
				Button(action: {
					dismiss()
				}, label: {
					CloseButton()
				})
			}
		}
		.padding()
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(colorScheme == .dark ? .black : .white)
		.clipShape(RoundedRectangle(cornerRadius: 30))
		.padding(.horizontal, 15)
	}
}

/// `CloseButton` is a reusable SwiftUI component that creates a stylized button commonly used for closing or dismissing views. It features a circular shape with an "xmark" symbol in the center, designed with accessibility and style in mind.
///
/// This component abstracts the common design and functionality of a close button, ensuring consistency and reducing redundancy across the app. It is customizable to fit various UI needs while maintaining a consistent look and feel.
///
/// ## Example Usage
/// Simply include `CloseButton()` in your view hierarchy where a close or dismiss action is needed. It automatically inherits the action defined in the parent view's `toolbar` or other container.
///
/// ```
/// .toolbar {
///     Button(action: {
///         dismiss()
///     }, label: {
///         CloseButton()
///     })
/// }
/// ```
/// - Note: This button uses `.accessibilityLabel(Text("Close"))` for enhanced accessibility, ensuring that the button's purpose is clear to all users.


struct CloseButton: View {
	var body: some View {
		Circle()
			.fill(Color.secondary.opacity(0.2))
			.frame(width: 30, height: 30)
			.overlay(
				Image(systemName: "xmark")
					.font(.system(size: 10, weight: .heavy, design: .rounded))
					.foregroundColor(.secondary)
			)
			.accessibilityLabel(Text("Close"))
			.buttonStyle(PlainButtonStyle())
	}
}

