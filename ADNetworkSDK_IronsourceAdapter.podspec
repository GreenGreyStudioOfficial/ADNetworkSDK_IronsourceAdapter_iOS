Pod::Spec.new do |s|
  s.name             = 'ADNetworkSDK_IronsourceAdapter'
  s.version          = '1.0.0'
  s.summary          = 'Mobidriven ADNetworkSDK Ironsource Adapter'

  s.homepage         = 'https://github.com/GreenGreyStudioOfficial/ADNetworkSDK_IronsourceAdapter_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Mobidriven' => 'info@mobidriven.com' }
  s.source           = { :git => 'https://github.com/GreenGreyStudioOfficial/ADNetworkSDK_IronsourceAdapter_iOS.git', :tag => "#{s.version}" }

  s.platform = :ios
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.dependency "IronSourceSDK"
  s.dependency "ADNetworkSDK"
  
  s.source_files = 'Sources/**/*'

  s.frameworks   = "Foundation", "UIKit"
  s.requires_arc = true
  s.static_framework = true
  s.user_target_xcconfig = { 'ONLY_ACTIVE_ARCH' => 'YES' } 
  s.xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
