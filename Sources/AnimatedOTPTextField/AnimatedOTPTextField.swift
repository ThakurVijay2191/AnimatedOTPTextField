// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// A customizable, animated OTP (One-Time Password) input view built with SwiftUI.
///
/// `AnimatedOTPTextField` provides a visually rich and interactive way for users to input verification codes.
/// It supports custom styles, animations, haptics, and asynchronous validation.
///
/// - Features:
///   - Configurable field count and appearance via `TextFieldConfig`
///   - Real-time async validation with state feedback
///   - Smooth animations on input and error shake effect on invalid entries
///   - Built-in “Done” keyboard toolbar button
///
/// - Important: Available from iOS 17.0 onwards.
///
/// Example:
/// ```swift
/// @State private var otp = ""
///
/// var body: some View {
///     AnimatedOTPTextField(value: $otp) { otp in
///         if otp.count == 6 {
///             let isValid = await validateOTP(otp)
///             return isValid ? .valid : .invalid
///         }
///         return .typing
///     }
///     .padding()
/// }
/// ```
@available(iOS 17.0, *)
public struct AnimatedOTPTextField: View {
    
    // MARK: - Properties
    
    /// Configuration defining the appearance and behavior of the OTP field.
    var config: TextFieldConfig
    
    /// A two-way binding that stores and updates the entered OTP value.
    @Binding var value: String
    
    /// An asynchronous callback triggered whenever the OTP value changes.
    ///
    /// Use this closure to perform validation or business logic, returning a `TypingState`
    /// to reflect the current validity of the input.
    var onChange: (String) async -> TypingState
    
    /// Creates a new animated OTP text field.
    ///
    /// - Parameters:
    ///   - config: The configuration object defining the field style and colors. Defaults to `.init()`.
    ///   - value: A binding to the OTP string being edited.
    ///   - onChange: An async closure that validates the OTP input and returns a typing state.
    public init(
        config: TextFieldConfig = .init(),
        value: Binding<String>,
        onChange: @escaping (String) async -> TypingState
    ) {
        self.config = config
        self._value = value
        self.onChange = onChange
    }
    
    // MARK: - Private State
    
    /// The current state of the OTP input (typing, valid, invalid).
    @State private var state: TypingState = .typing
    
    /// A trigger used to restart the invalid shake animation when input fails validation.
    @State private var invalidTrigger: Bool = false
    
    /// Tracks the focus state of the hidden text field.
    @FocusState private var isActive: Bool
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: config.style == .roundedBorder ? 6 : 10) {
            ForEach(0..<config.numberOfFields, id: \.self) { index in
                CharacterView(index)
            }
        }
        // Animate transitions for both input and focus changes.
        .animation(.easeInOut(duration: 0.25), value: value)
        .animation(.easeInOut(duration: 0.25), value: isActive)
        .compositingGroup()
        
        // Adds shaking animation for invalid input feedback.
        .phaseAnimator([0, 10, -10, 10, -5, 5, 0],
                       trigger: invalidTrigger,
                       content: { content, offset in
            content.offset(x: offset)
        }, animation: { _ in
            .linear(duration: 0.06)
        })
        // Provides haptic feedback when input is invalid.
        .sensoryFeedback(.error, trigger: invalidTrigger)
        
        // Hidden text field to capture input.
        .background {
            TextField("", text: $value)
                .focused($isActive)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .mask {
                    Rectangle()
                        .frame(width: 1, height: 1)
                        .opacity(0.01)
                }
                .allowsHitTesting(false)
        }
        .contentShape(.rect)
        .onTapGesture {
            isActive = true
        }
        
        // Responds to OTP text changes.
        .onChange(of: value) { oldValue, newValue in
            // Limit input length to the number of OTP fields.
            value = String(newValue.prefix(config.numberOfFields))
            
            // Validate asynchronously and update state.
            Task { @MainActor in
                state = await onChange(value)
                if state == .invalid {
                    invalidTrigger.toggle()
                }
            }
        }
        
        // Adds “Done” button to keyboard toolbar.
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isActive = false
                }
                .tint(.primary)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Builds the individual OTP character view at a specific index.
    ///
    /// Each character slot visually reflects the input and validation state.
    ///
    /// - Parameter index: The position of the OTP field (starting from 0).
    @ViewBuilder
    func CharacterView(_ index: Int) -> some View {
        Group {
            if config.style == .roundedBorder {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor(index), lineWidth: 1.2)
            } else {
                Rectangle()
                    .fill(borderColor(index))
                    .frame(height: 1)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .frame(width: config.otpBoxWidth, height: config.otpBoxHeight)
        .overlay {
            let stringValue = string(index)
            if stringValue != "" {
                Text(stringValue)
                    .font(config.font)
                    .transition(.blurReplace)
            }
        }
    }
    
    // MARK: - Utility Methods
    
    /// Retrieves the character for a given OTP box index.
    ///
    /// - Parameter index: The index of the field.
    /// - Returns: The corresponding character, or an empty string if out of bounds.
    func string(_ index: Int) -> String {
        if value.count > index {
            let startIndex = value.startIndex
            let stringIndex = value.index(startIndex, offsetBy: index)
            return String(value[stringIndex])
        }
        return ""
    }
    
    /// Determines the border color for a given field based on the current typing state.
    ///
    /// - Parameter index: The index of the field.
    /// - Returns: The appropriate color for the border or underline.
    func borderColor(_ index: Int) -> Color {
        switch state {
        case .typing:
            value.count == index && isActive ? config.activeColor : config.inactiveColor
        case .valid:
            config.validColor
        case .invalid:
            config.invalidColor
        }
    }
}
