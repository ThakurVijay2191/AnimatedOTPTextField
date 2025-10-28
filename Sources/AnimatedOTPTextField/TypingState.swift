//
//  SwiftUIView.swift
//  AnimatedOTPTextField
//
//  Created by Vijay Thakur on 28/10/25.
//

import Foundation

/// Represents the current typing / validation state of an OTP input flow.
///
/// Use this enum to communicate the visual/validation state of an OTP entry control:
/// - `.typing` — user is still entering digits (default interactive state)
/// - `.valid`  — the entered OTP has been validated and is considered correct
/// - `.invalid` — the entered OTP failed validation (use to trigger error animation / haptics)
///
/// - Note: Keep this type `public` so it can be exposed by Swift Packages and consumed by host apps.
///
/// Example
/// ```swift
/// // Example usage inside an async validation callback:
/// Task { @MainActor in
///     let state: TypingState
///     if otp.count == expectedLength {
///         let ok = await verify(otp)
///         state = ok ? .valid : .invalid
///     } else {
///         state = .typing
///     }
///     self.typingState = state
/// }
/// ```
public enum TypingState {
    /// The user is currently entering digits. Use this to show the active/inactive styling.
    case typing

    /// The entered value passed validation. Use this to show success styling.
    case valid

    /// The entered value failed validation. Use this to show error styling (color, shake, haptic).
    case invalid
}

