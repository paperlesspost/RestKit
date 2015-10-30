Pod::Spec.new do |s|
  s.name         			= 'RestKit'
  s.version      			= '0.10.35'
  s.summary      			= 'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     			= 'https://github.com/PaperlessPost/RestKit'
  s.author       			= { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       			= { :git => 'https://github.com/PaperlessPost/RestKit.git', :tag => s.version.to_s}
  s.license      			= 'Apache License, Version 2.0'  
  s.requires_arc 			= false
  s.platform          = :ios
  s.default_subspec   = 'Phone'
  
  s.ios.deployment_target = '8.0'
  
  rk_sources = [
    "Code/RestKit.h",
    "Code/CoreData/**/*.{h,m}",
    "Code/Network/**/*.{h,m}",
    "Code/ObjectMapping/**/*.{h,m}",
    "Code/Support/**/*.{h,m}",
    "Code/Testing/**/*.{h,m}",
    "Code/UI/**/*.{h,m}"
  ]

  vendor_sources = [
    "Vendor/SOCKit",
    "Vendor/FileMD5Hash", 
    "Vendor/LibComponentLogging/**/*.{h,m}", 
    "Vendor/XMLReader/**/*.{h,m}", 
    "Vendor/cocoa-oauth/**/*.{h,m}", 
    "Vendor/iso8601parser/**/*.{h,m}"
  ]

  s.subspec 'Phone' do |ss|    
    ss.source_files = rk_sources + vendor_sources
  end

  s.subspec 'Watch' do |ss|    
    ss.source_files = rk_sources + vendor_sources
    ss.xcconfig = { "OTHER_CFLAGS" => "$(inherited) -DRK_APP_EXTENSION" }
  end

end

