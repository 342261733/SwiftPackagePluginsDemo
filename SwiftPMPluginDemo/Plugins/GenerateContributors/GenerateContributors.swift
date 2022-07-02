
import Foundation
import PackagePlugin
//import Alamofire
// 友情其实：需要运行此 Demo 需要先有 git 提交记录。
@main
struct GenerateContributors: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/git")
        process.arguments = ["log", "--pretty=format:' %an <%ae>%n'"]
        
        let outputPipe = Pipe()
        process.standardOutput = outputPipe
        try process.run()
        process.waitUntilExit()
        
        let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(decoding: outputData, as: UTF8.self)
        
        print("GenerateContributors invoke")
        Diagnostics.emit(Diagnostics.Severity.error, "Diagnostics: GenerateContributors emit error")
        Diagnostics.error("Diagnostics: GenerateContributors error")
        Diagnostics.warning("Diagnostics: GenerateContributors warning")
        Diagnostics.remark("Diagnostics: GenerateContributors remark")
        
        let contributors = Set(output.components(separatedBy: CharacterSet.newlines)).sorted().filter { !$0.isEmpty }
        try contributors.joined(separator: "\n").write(toFile: "CONTRIBUTORS.txt", atomically: true, encoding: .utf8)
        
//        AF.request("https://www.baidu.com").response { response in
//            print(response)
//        }
    }
}
