Pod::Spec.new do |s|
    s.name         = "VisionFaceDetector"
    s.version      = "0.0.1"
    s.summary      = "A VisionCamera frame-processor plugin that uses Apple’s Vision.framework to detect faces on iOS."
    s.homepage     = "https://github.com/devxerpihan/vision-face-detector"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "yasa nugroho" => "yasa@xerpihan.id" }
    s.platform     = :ios, "12.0"
  
    # Pull plugin code from this GitHub repo at the specified tag
    s.source       = {
      :git => "https://github.com/devxerpihan/vision-face-detector.git",
      :tag => s.version
    }
  
    # Include the Swift implementation file
    s.source_files = "VisionFaceDetector.swift"
  
    # Dependency on VisionCamera core
    s.dependency 'VisionCamera'
  end
  