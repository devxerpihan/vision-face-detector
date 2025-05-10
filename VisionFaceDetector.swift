import VisionCamera
import Vision
import CoreMedia

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {
  // required initializer
  public override init(
    proxy: VisionCameraProxyHolder,
    options: [AnyHashable : Any]! = [:]
  ) {
    super.init(proxy: proxy, options: options)
  }

  // THIS must be named `detectFaces` to line up with the macro below
  @objc public override func detectFaces(
    _ frame: Frame,
    withArguments args: [AnyHashable : Any]?
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
