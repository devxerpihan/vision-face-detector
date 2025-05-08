Pod::Spec.new do |s|
    s.name         = "VisionFaceDetector"
    s.version      = "0.0.1"
    s.summary      = "A VisionCamera frame‐processor plugin that uses Apple’s Vision.framework to detect faces on iOS."
    s.homepage     = "https://github.com/devxerpihan/vision-face-detector"  # ← your repo
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "yasa nugroho" => "yasa@xerpihan.id" }
    s.platform     = :ios, "12.0"
  
    # point to the GitHub repo where you’ve pushed this plugin and tagged 0.0.1
    s.source       = { 
      :git => "https://github.com/devxerpihan/vision-face-detector.git", 
      :tag => "#{s.version}" 
    }
  
    s.source_files = "VisionFaceDetector.swift"
    s.dependency   = "VisionCamera"
  end
  