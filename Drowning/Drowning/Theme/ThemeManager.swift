import SwiftUI

class ThemeManager: ObservableObject {
    
    @AppStorage("selectedTheme") private var themeSelected = 0
    
    static let shared = ThemeManager()
    
    public var themes: [Theme] = [GreenTheme(), OrangeTheme(), RedTheme(), BlueTheme()]
    
    @Published var selectedTheme: Theme
    
    init() {
        let initialTheme = ThemeManager.initialTheme
        self._selectedTheme = Published(initialValue: initialTheme)
        self.getTheme() // Ensure the selected theme is set correctly
    }
    
    private static var initialTheme: Theme {
        let themeSelected = UserDefaults.standard.integer(forKey: "selectedTheme")
        let themes: [Theme] = [GreenTheme(), OrangeTheme(), RedTheme(), BlueTheme()]
        return themes[themeSelected]
    }
    
    public func applyTheme(_ theme: Int) {
        guard theme >= 0 && theme < themes.count else { return }
        self.selectedTheme = self.themes[theme]
        self.themeSelected = theme
    }
    
    private func getTheme() {
        self.selectedTheme = self.themes[themeSelected]
    }
    
    // Helper function to determine appropriate text color
    private func isLight(color: UIColor) -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate the perceived brightness of the color
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        return brightness > 0.5
    }
    
    // Computed property to determine appropriate text color
    var textColor: Color {
        let uiColor = UIColor(selectedTheme.secondaryColor)
        return isLight(color: uiColor) ? .black : .white
    }
}
