public struct MyLibrary {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

import Foundation

// 生成目录在 ~/Library/Developer/Xcode/DerivedData/MyLibrary-XXXXXX/SourcePackages/plugins/

public func GetLocalizedString() -> String {
    return NSLocalizedString("World", comment: "A comment about the localized string") //  .module  bundle: .main,
}


extension Bundle {
    static let module = Bundle(path: "\(Bundle.main.bundlePath)/MyLibrary")
}
