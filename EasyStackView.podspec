#
#  Be sure to run `pod spec lint EasyStackView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "EasyStackView"
  s.version      = "1.0.1"
  s.summary      = "Try this project to use flex layout is iOS native code."
  
  s.description  = <<-DESC
  This project equiped iOS native development with felx layout. It is simple but elegent. You can shake off massy frame layout or auto layout.
                   DESC

  s.homepage     = "https://github.com/Elenionl/EasyStackView"
  s.social_media_url   = "https://github.com/Elenionl"
  s.license      = "MIT"
  s.author       = { "Elenion" => "stellanxu@gmail.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/Elenionl/EasyStackView.git", :tag => "#{s.version}" }

  s.source_files  = "EasyStackView/**/*.{h,m}"
end
