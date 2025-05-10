// VisionFaceDetector.swift

import Foundation
import Vision
import VisionCamera    // v4 API
import CoreMedia       // for CMSampleBufferGetImageBuffer

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  // 👉 Rename from "callback" to "detectFaces"
  @objc public static func detectFaces(
    _ frame: Frame,
    withArguments args: [Any]?
  ) -> [[NSNumber]] {

    guard let sampleBuffer = frame.buffer as? CMSampleBuffer,
          let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
    else {
      return []
    }

    let request = VNDetectFaceRectanglesRequest()
    try? VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right,
      options: [:]
    ).perform([request])

    guard let results = request.results as? [VNFaceObservation] else {
      return []
    }

    return results.map { f in
      [
        NSNumber(value: f.boundingBox.origin.x),
        NSNumber(value: f.boundingBox.origin.y),
        NSNumber(value: f.boundingBox.size.width),
        NSNumber(value: f.boundingBox.size.height),
      ]
    }
  }
}

// 🚩 EXPORT under the name "detectFaces"
VISION_EXPORT_FRAME_PROCESSOR(VisionFaceDetector, detectFaces)
