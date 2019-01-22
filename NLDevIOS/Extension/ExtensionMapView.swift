//
//  ExtensionMapView.swift
//  NLDevIOS
//
//  Created by NLDeviOS on 22/1/2562 BE.
//  Copyright © 2562 ONaJa. All rights reserved.
//

import UIKit
import MapKit

extension MKMapView {

    func zoomMapFitAnnotations() {
        
        var zoomRect = MKMapRect.null
        for annotation in self.annotations {
            
            let annotationPoint = MKMapPoint(annotation.coordinate)
            
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
            
            if (zoomRect.isNull) {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        }
        self.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
        
    }

}
