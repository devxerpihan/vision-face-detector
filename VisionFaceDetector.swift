import Foundation
import Vision
import VisionCamera          // v4 API
import CoreMedia             // for CMSampleBufferGetImageBuffer

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  @objc public static func callback(
    _ frame: Frame,
    withArguments args: [Any]?
  ) -> [[NSNumber]] {

    // frame.buffer is *always* a CMSampleBuffer in v4
    let sampleBuffer: CMSampleBuffer = frame.buffer

    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
      return []
    }

    let request = VNDetectFaceRectanglesRequest()
    try? VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right,
      options: [:]
    ).perform([request])

    guard let faces = request.results as? [VNFaceObservation] else { return [] }

    return faces.map { f in
      [
        NSNumber(value: f.boundingBox.origin.x),
        NSNumber(value: f.boundingBox.origin.y),
        NSNumber(value: f.boundingBox.size.width),
        NSNumber(value: f.boundingBox.size.height),
      ]
    }
  }
}
