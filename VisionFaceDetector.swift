import Foundation
import Vision
import VisionCamera    // v4 API
import CoreMedia       // for CMSampleBufferGetImageBuffer

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  // ⚠️ Keep the name “callback” to match your JS initFrameProcessorPlugin(...)
  @objc public static func callback(
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

// ─── Export at file scope, not inside the class ───
VISION_EXPORT_FRAME_PROCESSOR(VisionFaceDetector, callback)
