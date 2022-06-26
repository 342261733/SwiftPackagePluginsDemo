// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftPMPluginDemo",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftPMPluginDemo",
            targets: ["SwiftPMPluginDemo"]),
//        .plugin(name: "GenstringsPlugin", targets: ["SwiftPMPluginDemo"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftPMPluginDemo",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftPMPluginDemoTests",
            dependencies: ["SwiftPMPluginDemo"]),
        .plugin(name: "GenerateContributors", capability: .command(intent: .custom(verb: "generate-contributors-list", description: "Generate the CONTRIBUTORS.txt file based on Git logs"), permissions: [.writeToPackageDirectory(reason: "Write CONTRIBUTORS.text to the source root.")])),
        
    ]
)
