import VisionCamera
import Vision
import CoreMedia

@objc(VisionFaceDetector)
public class VisionFaceDetector: FrameProcessorPlugin {
  
  public override init(
    proxy: VisionCameraProxyHolder,
    options: [AnyHashable:Any]! = [:]
  ) {
    super.init(proxy: proxy, options: options)
  }

  // keep this named `callback` since JS will initFrameProcessorPlugin("callback", {})
  public override func callback(
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

    let faces = (request.results as? [VNFaceObservation]) ?? []
    return faces.map { f in
      [
        NSNumber(value: f.boundingBox.origin.x),
        NSNumber(value: f.boundingBox.origin.y),
        NSNumber(value: f.boundingBox.size.width),
        NSNumber(value: f.boundingBox.size.height),
      ]
    ]
  }
}
