Pod::Spec.new do |s|
  s.name         			=  'RestKit'
  s.version      			=  '0.10.31-alpha.3'
  s.summary      			=  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     			=  'http://www.restkit.org'
  s.author       			=  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       			=  { :git => 'https://github.com/PaperlessPost/RestKit.git', :tag => s.version.to_s}
  s.license      			=  'Apache License, Version 2.0'

  # Platform Setup

  s.platform 	 			      =  :ios, "8.0"
  s.ios.deployment_target	=  "8.0"
  s.requires_arc 			    =  false

  s.default_subspecs = 'iOS'  

  s.subspec 'iOS' do |ss|
    ss.source_files =  "Code/**/*.{h,m}", "Vendor/SOCKit", "Vendor/FileMD5Hash", "Vendor/LibComponentLogging/**/*.{h,m}", "Vendor/XMLReader/**/*.{h,m}", "Vendor/cocoa-oauth/**/*.{h,m}", "Vendor/iso8601parser/**/*.{h,m}"
  end

  s.subspec 'AppExtension' do |ss| 
    ss.source_files =  "Code/**/*.{h,m}", "Vendor/SOCKit", "Vendor/FileMD5Hash", "Vendor/LibComponentLogging/**/*.{h,m}", "Vendor/XMLReader/**/*.{h,m}", "Vendor/cocoa-oauth/**/*.{h,m}", "Vendor/iso8601parser/**/*.{h,m}"
    ss.pod_target_xcconfig = {
        "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) WATCHOS_APP_EXTENSION"
    }
  end

end

