//
//  SwiftUIView.swift
//  AnimatedOTPTextField
//
//  Created by Vijay Thakur on 28/10/25.
//

import SwiftUI

/// A configuration model that defines the appearance and layout of the `AnimatedOTPTextField`.
///
/// Use this struct to customize how the OTP text fields are displayed — including
/// dimensions, colors, font, and overall style.
///
/// - Note: Marked `@available(iOS 17.0, *)` since it relies on newer SwiftUI APIs.
/// - Important: This struct should be passed to `AnimatedOTPTextField` when initializing.
///
/// Example
/// ```swift
/// let config = TextFieldConfig(
///     numberOfFields: 4,
///     style: .underlined,
///     otpBoxWidth: 45,
///     otpBoxHeight: 55,
///     inactiveColor: .gray.opacity(0.5),
///     activeColor: .blue,
///     validColor: .green,
///     invalidColor: .red,
///     font: .title3.bold()
/// )
///
/// AnimatedOTPTextField(config: config, value: $otp) { otp in
///     return otp.count == 4 ? .valid : .typing
/// }
/// ```
@available(iOS 17.0, *)
public struct TextFieldConfig {
    
    // MARK: - Properties
    
    /// Total number of OTP fields to display (e.g., 4, 6).
    public var numberOfFields: Int
    
    /// Visual style of each OTP field (`roundedBorder` or `underlined`).
    public var style: TextFieldStyle
    
    /// Width of each OTP box. Set `nil` to allow automatic sizing.
    public var otpBoxWidth: CGFloat?
    
    /// Height of each OTP box. Set `nil` to allow automatic sizing.
    public var otpBoxHeight: CGFloat?
    
    /// Color used when a field is inactive (not currently focused).
    public var inactiveColor: Color
    
    /// Color used when a field is active (user is typing in it).
    public var activeColor: Color
    
    /// Color used when the entered OTP is valid.
    public var validColor: Color
    
    /// Color used when the entered OTP is invalid.
    public var invalidColor: Color
    
    /// Font applied to the text displayed inside each field.
    public var font: Font
    
    // MARK: - Initializer
    
    /// Creates a new configuration for the OTP text field.
    ///
    /// - Parameters:
    ///   - numberOfFields: The total number of character fields to show. Default is 6.
    ///   - style: The visual style of the OTP field (rounded border or underlined).
    ///   - otpBoxWidth: Optional width of each OTP box.
    ///   - otpBoxHeight: Optional height of each OTP box.
    ///   - inactiveColor: The border or underline color when not active.
    ///   - activeColor: The border or underline color when active.
    ///   - validColor: The color shown when validation succeeds.
    ///   - invalidColor: The color shown when validation fails.
    ///   - font: The font style for the text displayed inside the field.
    public init(
        numberOfFields: Int = 6,
        style: TextFieldStyle = .roundedBorder,
        otpBoxWidth: CGFloat? = 50,
        otpBoxHeight: CGFloat? = 50,
        inactiveColor: Color = .gray,
        activeColor: Color = .primary,
        validColor: Color = .green,
        invalidColor: Color = .red,
        font: Font = .title2
    ) {
        self.numberOfFields = numberOfFields
        self.style = style
        self.otpBoxWidth = otpBoxWidth
        self.otpBoxHeight = otpBoxHeight
        self.inactiveColor = inactiveColor
        self.activeColor = activeColor
        self.validColor = validColor
        self.invalidColor = invalidColor
        self.font = font
    }
}
