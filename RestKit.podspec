Pod::Spec.new do |s|
  s.name         			=  'RestKit'
  s.version      			=  '0.10.31-alpha.1'
  s.summary      			=  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     			=  'http://www.restkit.org'
  s.author       			=  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       			=  { :git => 'git@github.com:paperlesspost/RestKit.git', :branch => 'feature/ios8_xcode7_dynamicframework_compat'}
  s.license      			=  'Apache License, Version 2.0'

  # Platform Setup

  s.platform 	 			=  :ios, "8.0"
  s.ios.deployment_target	=  "8.0"
  s.requires_arc 			=  false

  s.source_files 			=  "Code/**/*.{h,m}", "Vendor/SOCKit", "Vendor/FileMD5Hash", "Vendor/LibComponentLogging/**/*.{h,m}", "Vendor/XMLReader/**/*.{h,m}", "Vendor/cocoa-oauth/**/*.{h,m}", "Vendor/iso8601parser/**/*.{h,m}"



end

