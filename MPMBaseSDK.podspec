#
# Be sure to run `pod lib lint MPMBaseSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MPMBaseSDK'
  s.version          = '0.0.7'
  s.summary          = 'iOS开发基础组件库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DoneLiu/MPMBaseSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '823890952@qq.com' => 'Done.L' }
  s.source           = { :git => 'https://github.com/DoneLiu/MPMBaseSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  # s.resource_bundles = {
  #   'MPMBaseSDK' => ['MPMBaseSDK/Assets/*.png']
  # }

  s.source_files = 'MPMBaseSDK/MPMCategoryKit.h'
  s.public_header_files = 'MPMBaseSDK/MPMCategoryKit.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.requires_arc = true
  
  s.subspec 'NSData' do |cs|
      cs.source_files = 'MPMBaseSDK/NSData/*.{h,m}'
  end
  
  s.subspec 'NSDate' do |cs|
      cs.source_files = 'MPMBaseSDK/NSDate/*.{h,m}'
  end
  
  s.subspec 'NSDictionary' do |cs|
      cs.source_files = 'MPMBaseSDK/NSDictionary/*.{h,m}'
  end
  
  s.subspec 'NSString' do |cs|
      cs.source_files = 'MPMBaseSDK/NSString/*.{h,m}'
      cs.dependency 'YYText'
  end
  
  s.subspec 'NSURL' do |cs|
      cs.source_files = 'MPMBaseSDK/NSURL/*.{h,m}'
      cs.dependency 'SDWebImage'
      cs.dependency 'SDWebImage/WebP'
  end
  
  s.subspec 'UIAlertAction' do |cs|
      cs.source_files = 'MPMBaseSDK/UIAlertAction/*.{h,m}'
  end
  
  s.subspec 'UIButton' do |cs|
      cs.source_files = 'MPMBaseSDK/UIButton/*.{h,m}'
  end
  
  s.subspec 'UIFont' do |cs|
      cs.source_files = 'MPMBaseSDK/UIFont/*.{h,m}'
  end
  
  s.subspec 'UIImage' do |cs|
      cs.source_files = 'MPMBaseSDK/UIImage/*.{h,m}'
  end
  
  s.subspec 'UILabel' do |cs|
      cs.source_files = 'MPMBaseSDK/UILabel/*.{h,m}'
  end
  
  s.subspec 'UITextView' do |cs|
      cs.source_files = 'MPMBaseSDK/UITextView/*.{h,m}'
  end
  
  s.subspec 'UIView' do |cs|
      cs.source_files = 'MPMBaseSDK/UIView/*.{h,m}'
  end

end
