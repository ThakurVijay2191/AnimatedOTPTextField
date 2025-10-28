
# 🧩 AnimatedOTPTextField

A **lightweight, animated, and customizable OTP (One-Time Password) input field** built with **SwiftUI**.  
Designed for modern iOS apps that require smooth UX for verification, login, or authentication flows.

---

## ✨ Features

- 🔢 Configurable number of OTP fields (default: 6)
- 🎨 Two visual styles: Rounded Border & Underlined
- ⚡ Smooth animations and haptic feedback for invalid input
- 🧠 Asynchronous validation support (`async` `onChange`)
- 🧱 Fully customizable size, colors, and fonts using `TextFieldConfig`
- 📦 Ready-to-use Swift Package

---

## 🛠 Installation

### Swift Package Manager (SPM)

1. In Xcode, open **File ▸ Add Packages...**
2. Enter the repository URL:
   ```text
   https://github.com/yourusername/AnimatedOTPTextField.git
   ```
3. Choose **Add Package** and import it into your target.

Then import it where needed:
```swift
import AnimatedOTPTextField
```

---

## 💡 Usage

### Basic Example

```swift
import SwiftUI
import AnimatedOTPTextField

struct OTPExampleView: View {
    @State private var otpCode = ""

    var body: some View {
        AnimatedOTPTextField(value: $otpCode) { otp in
            if otp.count == 6 {
                let isValid = await validateOTP(otp)
                return isValid ? .valid : .invalid
            }
            return .typing
        }
        .padding()
    }

    func validateOTP(_ otp: String) async -> Bool {
        // Example async validation logic
        try? await Task.sleep(for: .seconds(1))
        return otp == "123456"
    }
}
```

---

## ⚙️ Configuration

Customize the appearance using `TextFieldConfig`:

```swift
let config = TextFieldConfig(
    numberOfFields: 4,
    style: .underlined,
    otpBoxWidth: 45,
    otpBoxHeight: 55,
    inactiveColor: .gray.opacity(0.5),
    activeColor: .blue,
    validColor: .green,
    invalidColor: .red,
    font: .title3.bold()
)

AnimatedOTPTextField(config: config, value: $otpCode) { otp in
    return otp.count == 4 ? .valid : .typing
}
```

---

## 📱 Preview

| Rounded Border | Underlined |
|----------------|-------------|
| ![Rounded Example](Docs/rounded.png) | ![Underlined Example](Docs/underlined.png) |

---

## 🧠 Typing State

`TypingState` defines the current OTP validation state:

```swift
enum TypingState {
    case typing    // user is entering input
    case valid     // valid OTP entered
    case invalid   // invalid OTP, triggers error animation
}
```

---

## 🧩 Example Repository Structure

```
AnimatedOTPTextField/
├── Sources/
│   └── AnimatedOTPTextField/
│       ├── AnimatedOTPTextField.swift
│       ├── TextFieldConfig.swift
│       ├── TypingState.swift
│       └── TextFieldStyle.swift
├── README.md
└── Package.swift
```

---

## 🧾 License

This project is licensed under the **MIT License**.  
See [LICENSE](LICENSE) for details.

---

### 👨‍💻 Author
**Vijay Thakur**  
iOS Developer | SwiftUI Enthusiast | Open Source Contributor  
[LinkedIn](https://www.linkedin.com/in/vijay-thakur-984646223) • [GitHub](https://github.com/ThakurVijay2191)
