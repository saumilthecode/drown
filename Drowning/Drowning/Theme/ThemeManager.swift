import SwiftUI

class ThemeManager: ObservableObject {
    
    @AppStorage("selectedTheme") private var themeSelected = 0
    
    static let shared = ThemeManager()
    
    public var themes: [Theme] = [GreenTheme(), OrangeTheme(), RedTheme(), BlueTheme()]
    
    @Published var selectedTheme: Theme
    
    // Change initializer to internal or fileprivate
    init() {
        self._selectedTheme = Published(initialValue: ThemeManager.initialTheme)
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
}
