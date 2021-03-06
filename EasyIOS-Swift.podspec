#
# Be sure to run `pod lib lint EasyIOS-Swift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EasyIOS-Swift"
  s.version          = "0.1.0"
  s.summary          = "The Swift version of EasyIOS"
  s.description      = <<-DESC
                      EasyIOS is a new generation of development framework based on `Model-View-ViewModel` which makes faster and easier app development, Build your app by geek's way.
                       DESC
  s.homepage         = "https://github.com/EasyIOS/EasyIOS-Swift"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "zhuchao" => "zhuchao@iosx.me" }
  s.source           = { :git => "/Users/zhuchao/Documents/EasyUI/EasyIOS-Swift", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.module_name = "EasyIOS"
  s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {'EasyIOS-Swift' => ['Pod/Assets/*.png']}
    s.dependency 'HanekeSwift', '~> 0.9.1'
    s.dependency 'Bond', '~> 3.7.1'
    s.dependency 'Alamofire', '~> 1.2'
    s.dependency 'SnapKit', '~> 0.11.0'
    s.dependency 'SDWebImage', '~>3.7'
s.public_header_files = 'Pod/Classes/Easy/**/*.h','Pod/Classes/Extend/**/*.h','Pod/Classes/Private/**/*.h'
s.frameworks = 'UIKit'
end
