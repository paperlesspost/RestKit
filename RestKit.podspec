Pod::Spec.new do |s|
  s.name         =  'RestKit'
  s.version      =  '0.10.3.PP'
  s.summary      =  'RestKit is a framework for consuming and modeling RESTful web resources on iOS and OS X.'
  s.homepage     =  'http://www.restkit.org'
  s.author       =  { 'Blake Watters' => 'blakewatters@gmail.com' }
  s.source       =  { :git => 'https://github.com/paperlesspost/RestKit.git', :tag => 'v#{s.version}' }
  s.license      =  'Apache License, Version 2.0'
  s.requires_arc =  false
  s.source_files =  'Code/RestKit.h'

  ### Preferred dependencies

  s.ios.deployment_target = '5.1.1'

  s.default_subspec = 'JSON'

  s.subspec 'JSON' do |js|
    js.dependency 'RestKit/Network'
    js.dependency 'RestKit/ObjectMapping/JSON'
    js.dependency 'RestKit/ObjectMapping/CoreData'
    js.dependency 'RestKit/ObjectMapping'
    js.dependency 'RestKit/UI'
    js.dependency 'RestKit/Testing'
  end

  s.subspec 'XML' do |xs|
    xs.dependency 'RestKit/Network'
    xs.dependency 'RestKit/ObjectMapping/XML'
    xs.dependency 'RestKit/ObjectMapping/CoreData'
    xs.dependency 'RestKit/UI'
  end

  ### Subspecs

  s.subspec 'Network' do |ns|
    ns.source_files   = 'Code/Network', 'Code/Support'
    ns.ios.frameworks = 'CFNetwork', 'Security', 'MobileCoreServices', 'SystemConfiguration'
    ns.osx.frameworks = 'CoreServices', 'Security', 'SystemConfiguration'
    ns.dependency     'RestKit/Support'
  end

  s.subspec 'Support' do |ss|
    ss.source_files   = 'Code/RestKit.h', 'Code/Support.h', 'Code/Support', 'Vendor/LibComponentLogging/Core'    
  end

  s.subspec 'UI' do |us|
    us.ios.source_files = 'Code/UI'
    us.ios.framework    = 'QuartzCore'    
    us.osx.source_files = 'Code/UI/UIImage+RKAdditions.{h,m}'
    us.dependency     'RestKit/Support'
  end

  s.subspec 'ObjectMapping' do |os|    
    os.dependency     'RestKit/Network'
    os.dependency     'RestKit/Support'

    os.subspec 'Core' do |cos|
      cos.source_files = 'Code/ObjectMapping/'
    end

    os.subspec 'JSON' do |jos|
      jos.source_files = 'Code/Support/Parsers/JSON/RKJSONSerialization.{h,m}'    
      jos.dependency     'RestKit/ObjectMapping/Core'
    end

    os.subspec 'XML' do |xos|
      xos.source_files = 'Code/Support/Parsers/XML/RKXMLParserXMLReader.{h,m}'
      xos.libraries    = 'xml2'      
      xos.dependency     'RestKit/ObjectMapping/Core'      
    end

    os.subspec 'CoreData' do |cdos|
      cdos.source_files = 'Code/CoreData'
      cdos.frameworks   = 'CoreData'
      cdos.dependency     'RestKit/ObjectMapping/Core'      
    end
  end

  s.subspec 'Testing' do |ts|
    ts.source_files = 'Code/Testing'
  end

   s.subspec 'Support' do |ss|
    ss.source_files = 'Code/RestKit.h', 'Code/Support/Support.h', 'Code/Support', 'Code/UI/', 'Vendor/LiclearbComponentLogging/Core', 'Vendor/FileMD5Hash', 'Vendor/SOCKit', 'Vendor/XMLReader', 'Vendor/cocoa-oauth', 'Vendor/iso8601parser'
  end

end