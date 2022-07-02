import Alamofire
import Foundation

public struct SwiftPMPluginDemo {
    public private(set) var text = "Hello, World!"

    public init() {
        
        AF.request("https://www.baidu.com").response { response in
            print(response)
        }
    }
}
