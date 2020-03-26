#
#  Be sure to run `pod spec lint EasyAnimations.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "EasyAnimations"
  spec.version      = "1.0.0"
  spec.summary      = "A Tools easy Animation for Objective-C"
  spec.description  = <<-DESC
                      This is a tools easy Animation for Objective-C.
                    DESC

  spec.homepage     = "https://github.com/XuFeng-Li/EasyAnimations"
  spec.license      = "MIT"
  spec.author       = { "XuFeng-Li" => "1125105110@qq.com" } 
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/XuFeng-Li/EasyAnimations.git", :tag => spec.version.to_s } 

  spec.source_files    = "Animations/*"

  spec.frameworks    = 'Foundation', 'CoreGraphics', 'UIKit' 

end
