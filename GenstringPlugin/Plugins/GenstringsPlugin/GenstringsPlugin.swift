
import PackagePlugin
import Foundation

@main
struct GenstringsPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        guard let target = target as? SourceModuleTarget else {
            return []
        }
        
        let resourcesDirectoryPath = context.pluginWorkDirectory
            .appending(subpath: target.name)
            .appending(subpath: "Resources")
        let localizationDirectoryPath = resourcesDirectoryPath.appending(subpath: "Base.lproj")
        
        try FileManager.default.createDirectory(atPath: localizationDirectoryPath.string, withIntermediateDirectories: true)
        
        let swiftSourceFiles = target.sourceFiles(withSuffix: ".swift")
        let inputFiles = swiftSourceFiles.map(\.path)
        print("swift file: \(swiftSourceFiles), inputfile: \(inputFiles)")
        print("GenstringsPlugin invoke")
//        Diagnostics.emit(Diagnostics.Severity.error, "Diagnostics: GenstringsPlugin emit error")
//        Diagnostics.error("Diagnostics: GenstringsPlugin error")
//        Diagnostics.warning("Diagnostics: GenstringsPlugin warning")
//        Diagnostics.remark("Diagnostics: GenstringsPlugin remark")
        
        let gitLogPath = context.pluginWorkDirectory.appending(subpath: "gstlog.txt")
//        try FileManager.default.createFile(atPath: gitLogPath.string, contents: nil)
        
        return [
            .prebuildCommand(displayName: "Generating Iocalized strings from source files", executable: .init("/usr/bin/xcrun"), arguments: ["genstrings", "-SwiftUI", "-o", localizationDirectoryPath] + inputFiles, outputFilesDirectory: localizationDirectoryPath),
//            .prebuildCommand(displayName: "build command git status", executable: .init( "/usr/bin/sh"), arguments: ["ls"], outputFilesDirectory: localizationDirectoryPath)
            .buildCommand(displayName: "build command git status", executable: .init( "/usr/bin/git"), arguments: ["status"], outputFiles: [gitLogPath])
        ]
    }
}
