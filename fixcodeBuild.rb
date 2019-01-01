
#!/usr/bin/env ruby

require 'xcodeproj'

project_path = ARGV[0] || Dir.glob("./*.xcodeproj")[0]
project = Xcodeproj::Project.open(project_path)
project.targets.each do |target|
  # suppress warnings
  if [
    "Nimble",
    "Quick",
    "RxSwift",
    "RxCocoa"
  ].include? target.name
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_SUPPRESS_WARNINGS'] = 'YES'
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = 'YES'
    end
  end
end
