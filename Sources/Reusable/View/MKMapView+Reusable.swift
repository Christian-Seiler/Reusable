//
//  MKMapView+Reusable.swift
//  Reusable
//
//  Created by Christian Seiler on 04.09.19.
//

import MapKit

// MARK: Reusable support for MKMapView
@available(iOS 11.0, *)
public extension MKMapView {

    /**
     Register a Class-Based `MKAnnotationView` subclass (conforming to `Reusable`)
     - parameter annotationType: the `MKAnnotationView` (`Reusable`-conforming) subclass to register
     - seealso: `register(_:,forCellReuseIdentifier:)`
     */
    final func register<T: MKAnnotationView>(annotationType: T.Type) where T: Reusable {
        self.register(annotationType.self, forAnnotationViewWithReuseIdentifier: annotationType.reuseIdentifier)
    }

    /**
     Returns a reusable `MKAnnotationView` object for the class inferred by the return-type
     - parameter annotation: The annotation for the Annotation View
     - parameter annotationType: The annotation class to dequeue
     - returns: A `Reusable`, `MKAnnotationView` instance
     - note: The `annotationType` parameter can generally be omitted and infered by the return type,
     except when your type is in a variable and cannot be determined at compile time.
     - seealso: `dequeueReusableCell(withIdentifier:,for:)`
     */
    final func dequeueReusableCell<T: MKAnnotationView>(for annotation: MKAnnotation, annotationType: T.Type = T.self) -> T
        where T: Reusable {
        guard let annotationView = self.dequeueReusableAnnotationView(withIdentifier: annotationType.reuseIdentifier, for: annotation) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(annotationType.reuseIdentifier) matching type \(annotationType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return annotationView

    }
}
