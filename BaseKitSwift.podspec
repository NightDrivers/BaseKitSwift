Pod::Spec.new do |s|
  s.name         = "BaseKitSwift"
  s.version      = "5.1.0"
  s.summary      = "简单的开发库"
  s.swift_version = "5"
  s.description  = <<-DESC
  "一个包含常用api的库"
                   DESC
  s.homepage = 'https://github.com/NightDrivers'
  s.license      = "MIT"
  s.author       = { "NightDriver" => "lin_de_chun@sina.com" }
  s.source       = { :git => "https://github.com/NightDrivers/BaseKitSwift.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/BaseKitSwift/*/*.swift"
  s.ios.deployment_target = '8.0'
  s.dependency "SnapKit"
  #s.exclude_files = "Classes/Exclude"
end
