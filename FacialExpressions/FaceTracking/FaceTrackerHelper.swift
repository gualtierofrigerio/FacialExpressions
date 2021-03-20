//
//  FaceTrackerHelper.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 13/03/21.
//

import ARKit

fileprivate let threshold:Float = 0.5

class FaceTrackerHelper {
    func facialExpression(fromFaceAnchor faceAnchor:ARFaceAnchor) -> FacialExpressions {
        var expressions = FacialExpressions()
        // blink
        expressions.blinkStatus = blinkStatus(fromFaceAnchor: faceAnchor)
        // jaw open
        expressions.jawOpen = blendShapeActive(faceAnchor: faceAnchor, shape: .jawOpen)
        // mouth close
        expressions.mouthClose = blendShapeActive(faceAnchor:faceAnchor, shape: .mouthClose)
        // toungue
        expressions.toungueOut = blendShapeActive(faceAnchor: faceAnchor, shape: .tongueOut)
        
        print("lookAtPoint x = \(faceAnchor.lookAtPoint.x) y = \(faceAnchor.lookAtPoint.y)")
        
        faceLookHelper.update(x: faceAnchor.lookAtPoint.x, y: faceAnchor.lookAtPoint.y)
        expressions.lookUp = faceLookHelper.currentFaceLook.lookUp
        expressions.lookDown = faceLookHelper.currentFaceLook.lookDown
        expressions.lookLeft = faceLookHelper.currentFaceLook.lookLeft
        expressions.lookRight = faceLookHelper.currentFaceLook.lookRight
        
        expressions.isNodding = faceLookHelper.currentFaceLook.isNodding
        expressions.isShaking = faceLookHelper.currentFaceLook.isShaking
                
        return expressions
    }
    
    
    // MARK: - Private
    private var faceLookHelper = FaceLookHelper()
    
    private func blinkStatus(fromFaceAnchor faceAnchor:ARFaceAnchor) -> BlinkStatus {
        var blinkStatus:BlinkStatus = .none
        // check blink status
        // the values are mirrored, .eyeBlinkLeft is referred to the right eye
        if let leftEyeBlink = faceAnchor.blendShapes[.eyeBlinkLeft] as? Float {
            if leftEyeBlink > threshold {
                blinkStatus = .rightEye
            }
        }
        if let rightEyeBlink = faceAnchor.blendShapes[.eyeBlinkRight] as? Float {
            if rightEyeBlink > threshold {
                blinkStatus = blinkStatus == .rightEye ? .bothEyes : .leftEye
            }
        }
        
        return blinkStatus
    }
    
    private func blendShapeActive(faceAnchor:ARFaceAnchor,
                                shape:ARFaceAnchor.BlendShapeLocation) -> Bool {
        if let value = faceAnchor.blendShapes[shape] as? Float {
            return value > threshold
        }
        return false
    }
}
