//
//  FaceLookHelper.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 14/03/21.
//

import Foundation

struct FaceLook {
    var lookLeft    = false
    var lookRight   = false
    var lookUp      = false
    var lookDown    = false
    
    var isNodding   = false
    var isShaking   = false
}

extension FaceLook {
    mutating func reset() {
        lookLeft = false
        lookRight = false
        lookUp = false
        lookDown = false
    }
}

class FaceLookHelper {
    var currentFaceLook = FaceLook()
    
    func update(x:Float, y:Float) {
        currentFaceLook.reset()
        
        if y < -verticalThreshold {
            currentFaceLook.lookUp = true
            latestLookUpDate = Date()
        }
        if y > verticalThreshold {
            currentFaceLook.lookDown = true
            latestLookDownDate = Date()
        }

        if x > horizontalThreshold {
            currentFaceLook.lookLeft = true
            latestLookLeftDate = Date()
        }
        
        if x < -horizontalThreshold {
            currentFaceLook.lookRight = true
            latestLookRightDate = Date()
        }
        
        currentFaceLook.isNodding = checkNod()
        currentFaceLook.isShaking = checkShake()
    }
    
    private var latestLookUpDate:Date = Date()
    private var latestLookDownDate:Date = Date()
    private var latestLookLeftDate:Date = Date()
    private var latestLookRightDate:Date = Date()
    
    private func checkNod() -> Bool {
        let timeInterval = abs(latestLookUpDate.timeIntervalSince(latestLookDownDate))
        print("checkNod time \(timeInterval)")
        return timeInterval < timeThreshold
    }
    
    private func checkShake() -> Bool {
        let timeInterval = abs(latestLookLeftDate.timeIntervalSince(latestLookRightDate))
        print("checkShake time \(timeInterval)")
        return timeInterval < timeThreshold
    }
}

// MARK: - file private

fileprivate let verticalThreshold:Float = 0.05
fileprivate let horizontalThreshold:Float = 0.05
fileprivate let timeThreshold:TimeInterval = 0.5 // 500ms
