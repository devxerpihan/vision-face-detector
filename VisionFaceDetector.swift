import Foundation
import Vision
import VisionCamera

@objc(VisionFaceDetector)
public class VisionFaceDetector: NSObject, FrameProcessorPluginBase {
  @objc public static func requiresMainQueueSetup() -> Bool { false }
  @objc public static func name() -> String { "scanFaces" }

  public static func callback(
    _ frame: Frame!,
    resolver resolve: @escaping Resolve,
    rejecter reject: @escaping Reject
  ) {
    guard let buffer = frame.buffer else {
      return resolve([])
    }

    let request = VNDetectFaceRectanglesRequest { req, err in
      guard err == nil, let obs = req.results as? [VNFaceObservation] else {
        return resolve([])
      }
      let boxes = obs.map { f in
        [
          NSNumber(value: f.boundingBox.origin.x),
          NSNumber(value: f.boundingBox.origin.y),
          NSNumber(value: f.boundingBox.size.width),
          NSNumber(value: f.boundingBox.size.height),
        ]
      }
      resolve(boxes)
    }

    let handler = VNImageRequestHandler(
      cvPixelBuffer: buffer,
      orientation: .right,
      options: [:]
    )
    do {
      try handler.perform([request])
    } catch {
      resolve([])
    }
  }
}
