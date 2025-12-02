// source: https://rtorres.me/blog/convert-a-hex-color-to-uicolor-in-swift/
// source: https://rtorres.me/blog/how-to-convert-uicolor-to-hex-in-swift/

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.charactersToBeSkipped = nil
        
        // Consume optional `#`
        _ = scanner.scanString("#")
        
        switch scanner.charactersLeft() {
        case 6, 8:
            guard let red = scanner.scanHexByte(),
                  let green = scanner.scanHexByte(),
                  let blue = scanner.scanHexByte() else {
                return nil
            }
            
            var alpha: UInt8 = 255
            
            // Parse alpha if available
            if scanner.charactersLeft() == 2 {
                guard let parsedAlpha = scanner.scanHexByte() else {
                    return nil
                }
                
                alpha = parsedAlpha
            }
            
            self.init(
                red: CGFloat(red) / 255,
                green: CGFloat(green) / 255,
                blue: CGFloat(blue) / 255,
                alpha: CGFloat(alpha) / 255
            )
        case 3:
            guard let red = scanner.scanHexNibble(),
                  let green = scanner.scanHexNibble(),
                  let blue = scanner.scanHexNibble() else {
                return nil
            }
            
            self.init(
                red: CGFloat(red) / 15,
                green: CGFloat(green) / 15,
                blue: CGFloat(blue) / 15,
                alpha: 1
            )
        default:
            return nil
        }
    }
    
    func toHex() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            assertionFailure("Failed to get RGBA components from UIColor")
            return "#000000"
        }
        
        // Clamp components to [0.0, 1.0]
        red = max(0, min(1, red))
        green = max(0, min(1, green))
        blue = max(0, min(1, blue))
        alpha = max(0, min(1, alpha))
        
        if alpha == 1 {
            // RGB
            return String(
                format: "#%02lX%02lX%02lX",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255))
            )
        } else {
            // RGBA
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(round(red * 255)),
                Int(round(green * 255)),
                Int(round(blue * 255)),
                Int(round(alpha * 255))
            )
        }
    }
}

private extension Scanner {
    func scanHexNibble() -> UInt8? {
        guard let character = scanCharacter(), character.isHexDigit else {
            return nil
        }
        
        return UInt8(String(character), radix: 16)
    }
    
    func scanHexByte() -> UInt8? {
        guard let highNibble = scanHexNibble(), let lowNibble = scanHexNibble() else {
            return nil
        }
        
        return (highNibble << 4) | lowNibble
    }
    
    func charactersLeft() -> Int {
        return string.count - currentIndex.utf16Offset(in: string)
    }
}

