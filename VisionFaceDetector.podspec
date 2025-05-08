Pod::Spec.new do |s|
    s.name         = "VisionFaceDetector"
    s.version      = "0.0.2"
    s.summary      = "Vision.framework face detector for VisionCamera v4"
    s.homepage     = "https://github.com/devxerpihan/vision-face-detector"
    s.license      = { :type => "MIT" }
    s.author       = { "yasa nugroho" => "yasa@xerpihan.id" }
    s.platform     = :ios, "12.0"
    s.source_files = "VisionFaceDetector.swift"
    s.dependency   "VisionCamera", "~> 4.6"
  end
  