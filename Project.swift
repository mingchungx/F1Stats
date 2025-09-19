import ProjectDescription

let project = Project(
    name: "F1Stats",
    targets: [
        .target(
            name: "F1Stats",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.F1Stats",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["F1Stats/Sources/**"],
            resources: ["F1Stats/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "F1StatsTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.F1StatsTests",
            infoPlist: .default,
            sources: ["F1Stats/Tests/**"],
            resources: [],
            dependencies: [.target(name: "F1Stats")]
        ),
    ]
)
