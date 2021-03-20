//
//  FaceTrackerAR.swift
//  FacialExpressions
//
//  Created by Gualtiero Frigerio on 13/03/21.
//

import ARKit
import Combine

class FaceTrackerAR: UIViewController {
    
    init() {
        session = ARSession()
        super.init(nibName: nil, bundle: nil)
        session.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    @Published private var currentExpression = FacialExpressions()
    private var faceTrackerHelper = FaceTrackerHelper()
    private var session:ARSession
}

// MARK: - FaceTracker

extension FaceTrackerAR: FaceTracker {
    var expressionsPublisher: AnyPublisher<FacialExpressions, Never> {
        $currentExpression.eraseToAnyPublisher()
    }
    
    static func isAvailable() -> Bool {
        ARFaceTrackingConfiguration.isSupported
    }
    
    func start() {
        let configuration = ARFaceTrackingConfiguration()
        session.run(configuration, options: [])
    }
    
    func stop() {
        session.pause()
    }
}

// MARK: - ARSessionDelegate

extension FaceTrackerAR: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else { return }
        currentExpression = faceTrackerHelper.facialExpression(fromFaceAnchor: faceAnchor)
    }
    
    
}
