def xcodeProject = new io.intrepid.XcodeProject()
xcodeProject.name = "lucien-ios"
xcodeProject.xcodeVersion = '9'
xcodeProject.simulator = 'iPhone 7 (11.0)'

xcodeProject.addBuild([
  configuration: "Release"
])

def config = [
  slack: [
    enabled: true,
    channel: "#lucien-ios"
  ]
]

xcodePipeline(this, xcodeProject, config)
