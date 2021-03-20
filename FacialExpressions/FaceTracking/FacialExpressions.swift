//
//  FacialExpression.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 13/03/21.
//

import Foundation

enum BlinkStatus {
    case leftEye
    case rightEye
    case bothEyes
    case none
}


struct FacialExpressions {
    var blinkStatus:BlinkStatus = .none
    var jawOpen = false
    var mouthClose = false
    var toungueOut = false
    var lookLeft = false
    var lookRight = false
    var lookUp = false
    var lookDown = false
    var isNodding = false
    var isShaking = false
}

extension FacialExpressions {
    func leftBlink() -> Bool {
        blinkStatus == .leftEye || blinkStatus == .bothEyes
    }
    
    func righBlink() -> Bool {
        blinkStatus == .rightEye || blinkStatus == .bothEyes
    }
}
