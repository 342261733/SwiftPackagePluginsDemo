
import Foundation
import PackagePlugin
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
        
        print("semyon: >>>>>>>>>>>>>>>>>")
        
        let contributors = Set(output.components(separatedBy: CharacterSet.newlines)).sorted().filter { !$0.isEmpty }
        try contributors.joined(separator: "\n").write(toFile: "CONTRIBUTORS.txt", atomically: true, encoding: .utf8)
    }
}
