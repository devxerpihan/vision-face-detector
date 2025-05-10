import VisionCamera       // the React-Native VisionCamera module
import Vision             // for VNDetectFaceRectanglesRequest
import CoreMedia          // for CMSampleBufferGetImageBuffer

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  // ⚠️ Keep this exactly as "callback" to match your JS registration
  @objc public static func callback(
    _ frame: Frame,
    withArguments args: [Any]?
  ) -> [[NSNumber]] {
    guard
      let sampleBuffer = frame.buffer as? CMSampleBuffer,
      let pixelBuffer  = CMSampleBufferGetImageBuffer(sampleBuffer)
    else {
      return []
    }

    let request = VNDetectFaceRectanglesRequest()
    try? VNImageRequestHandler(
      cvPixelBuffer: pixelBuffer,
      orientation: .right,
      options: [:]
    ).perform([request])

    guard let observations = request.results as? [VNFaceObservation] else {
      return []
    }

    return observations.map { obs in
      [
        NSNumber(value: obs.boundingBox.origin.x),
        NSNumber(value: obs.boundingBox.origin.y),
        NSNumber(value: obs.boundingBox.size.width),
        NSNumber(value: obs.boundingBox.size.height),
      ]
    ]
  }
}
