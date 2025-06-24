//
//  MapViewWithRoute.swift
//  BikeBuddy
//
//  Created by Leonard Zgonjanin on 23.05.25.
//

import SwiftUI
import MapKit

struct MapViewWithRoute: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    var userLocation: CLLocationCoordinate2D?
    var route: [CLLocationCoordinate2D]

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)

        // Route anzeigen
        uiView.removeOverlays(uiView.overlays)
        let polyline = MKPolyline(coordinates: route, count: route.count)
        uiView.addOverlay(polyline)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = .blue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
