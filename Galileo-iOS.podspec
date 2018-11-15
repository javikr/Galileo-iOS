#
# Be sure to run `pod lib lint Galileo-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Galileo-iOS'
  s.version          = '0.1.3'
  s.summary          = 'Easy-to-use debugging tool for your iOS app!'
  s.description      = <<-DESC
Easy-to-use debugging tool for your iOS app! Shake your device and go! Inspired in the Galileo Android Tool (https://github.com/josedlpozo/Galileo). 
                       DESC
  s.homepage         = 'https://github.com/javikr/Galileo-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Javier Aznar de los Rios' => 'javikr@gmail.com' }
  s.source           = { :git => 'https://github.com/javikr/Galileo-iOS.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'Galileo-iOS/Classes/**/*.swift'
  s.resources = [ 'Galileo-iOS/**/*.{lproj,xcassets,xib,png}' ]
  s.frameworks = 'UIKit'
  s.dependency 'Wormholy'
  s.swift_version = '4.2'
  
  
  
  s.resources = [ 'Galileo-iOS/**/*.{lproj,xcassets,xib,png}' ]
  s.resource_bundles = {
      'Galileo' => [ 'Galileo-iOS/**/*.{xib,png,xcassets}' ]
  }
end
