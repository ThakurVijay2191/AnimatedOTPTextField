//
//  SwiftUIView.swift
//  AnimatedOTPTextField
//
//  Created by Vijay Thakur on 28/10/25.
//

import Foundation

/// Defines the visual style of each OTP text field box.
///
/// Use this enum to configure how each OTP character slot appears in the UI:
/// - `.roundedBorder` — displays each field as a rounded rectangle with a border.
/// - `.underlined` — displays each field as an underline (similar to text entry fields).
///
/// This type conforms to `CaseIterable`, making it easy to use in pickers or style selectors.
///
/// Example
/// ```swift
/// // Apply rounded border style to the OTP view:
/// let config = TextFieldConfig(style: .roundedBorder)
///
/// // Or iterate over all styles (for settings screens, previews, etc.)
/// ForEach(TextFieldStyle.allCases, id: \.self) { style in
///     Text(style.rawValue)
/// }
/// ```
public enum TextFieldStyle: String, CaseIterable {
    /// A rounded rectangle with a visible border.
    case roundedBorder = "Rounded Border"

    /// A simple underline drawn beneath each character box.
    case underlined = "Underlined"
}
