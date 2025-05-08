import Foundation
import Vision
import VisionCamera          // v4 API

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  /// JS side calls `scanFaces(frame)`
  @objc public static func callback(
    _ frame: Frame,
    withArguments args: [Any]?
  ) -> [[NSNumber]] {

    guard let buffer = frame.buffer else { return [] }

    let request = VNDetectFaceRectanglesRequest()
    try? VNImageRequestHandler(
      cvPixelBuffer: buffer,
      orientation: .right,
      options: [:]
    ).perform([request])

    guard let faces = request.results as? [VNFaceObservation] else { return [] }

    return faces.map { f in
      [
        NSNumber(value: f.boundingBox.origin.x),
        NSNumber(value: f.boundingBox.origin.y),
        NSNumber(value: f.boundingBox.size.width),
        NSNumber(value: f.boundingBox.size.height)
      ]
    }
  }
}
