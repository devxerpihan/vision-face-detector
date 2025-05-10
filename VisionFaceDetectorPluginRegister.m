#import <VisionCamera/FrameProcessorPlugin.h>
#import <VisionCamera/FrameProcessorPluginRegistry.h>
#import "VisionFaceDetector-Swift.h"

// Register the Swift class/method under the JS name "detectFaces"
VISION_EXPORT_SWIFT_FRAME_PROCESSOR(VisionFaceDetector, detectFaces)
