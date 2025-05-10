import VisionCamera
import Vision
import CoreMedia
import Vision

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {

  // ← Only this method—no init override at all
  @objc public static func callback(
    _ frame: Frame,
    withArguments args: [AnyHashable:Any]?
  ) -> Any {
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

    let observations = (request.results as? [VNFaceObservation]) ?? []
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
