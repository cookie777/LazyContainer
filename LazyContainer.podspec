#
# Be sure to run `pod lib lint LazyContainer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LazyContainer'
  s.version          = 'v0.1.0-pre-release'
  s.summary          = 'A Lazy initializing container for Dependency injection. The registered classes will not constructed until they are called'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  `LazyContainer` is a simple class to contain multiple class and struct. A registered class or struct is not constructed until it is called, and return the cache after the second call.
  It also has a `Builder` class to simply store the lazy constructer. Both `LazyContainer` and `Builder` can be used variable purpose such as dependency injection and caching.
                       DESC

  s.homepage         = 'https://github.com/cookie777/LazyContainer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cookie777' => 'takayuki.contact@gmail.com' }
  s.source           = { :git => 'https://github.com/cookie777/LazyContainer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_versions = '5.5'
  s.source_files = 'Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'LazyContainer' => ['LazyContainer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
