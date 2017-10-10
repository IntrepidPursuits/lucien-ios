def xcodeProject = new io.intrepid.XcodeProject()
xcodeProject.name = "lucien-ios"
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
