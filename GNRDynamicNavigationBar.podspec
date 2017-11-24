Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "GNRDynamicNavigationBar"
s.summary = "Dynamic navigation bar."
s.requires_arc = true
s.version = "0.0.3"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Gustavo Campos" => "gustavo.sgarbi.campos@gmail.com" }
s.homepage = "https://github.com/gnrcampos/GNRDynamicNavigationBar"
s.source = { :git => "https://github.com/gnrcampos/GNRDynamicNavigationBar.git", :tag => "#{s.version}"}
s.framework = "UIKit"
s.dependency 'SnapKit', '~> 4.0.0'
s.source_files = "GNRDynamicNavigationBar/**/*.{swift}"
s.resources = ["GNRDynamicNavigationBar/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}", "GNRDynamicNavigationBar/Assets.xcassets"]

end
