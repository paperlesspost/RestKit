Pod::Spec.new do |s|
  s.name         			=  'RestKit'
  s.version      			=  '0.10.32'
  s.summary      			=  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     			=  'https://github.com/RestKit/RestKit'
  s.author       			=  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       			=  { :git => 'https://github.com/PaperlessPost/RestKit.git', :tag => s.version.to_s}
  s.license      			=  'Apache License, Version 2.0'

  s.platform 	 			      =  :ios
  
  s.ios.deployment_target	=  "8.0"
  
  s.requires_arc 			    =  false

  s.source_files =  "Code/**/*.{h,m}", "Vendor/SOCKit", "Vendor/FileMD5Hash", "Vendor/LibComponentLogging/**/*.{h,m}", "Vendor/XMLReader/**/*.{h,m}", "Vendor/cocoa-oauth/**/*.{h,m}", "Vendor/iso8601parser/**/*.{h,m}"

  s.default_subspec = 'iOS'

  s.subspec 'iOS' do |ss|
    ss.dependency 'RestKit/UniversalDependencies'
  end

  s.subspec 'AppExtension' do |ss|    
    ss.dependency 'RestKit/UniversalDependencies'
    ss.pod_target_xcconfig = {
        "GCC_PREPROCESSOR_DEFINITIONS" => "$(inherited) WATCHOS_APP_EXTENSION"
    }
  end

  s.subspec 'UniversalDependencies' do |ss|
    ss.dependency 'NSData+Base64', '~> 1.0'
  end

end

