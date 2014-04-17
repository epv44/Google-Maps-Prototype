//
//  ViewController.h
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ViewController : UIViewController <GMSMapViewDelegate>
    @property (strong, nonatomic) GMSMapView *mapView;

@end
