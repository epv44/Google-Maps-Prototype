//
//  Landmark.h
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>
@interface Landmark : NSObject <GMSMapViewDelegate>{
    NSString *title;
    GMSMarker *landmarkMarker;
    NSString *landmarkPositionString;
    NSValue *coordinate;
}

@property(nonatomic, readwrite) NSString *title;
@property(nonatomic, copy) GMSMarker *landmarkMarker;
@property(nonatomic, readwrite) NSString *landmarkPositionString;
@property(nonatomic, readwrite) NSValue *coordinate;
-(id) initWithTitle: (NSString *) landmarkTitle latitude: (double) lat longitude: (double) lon;
-(void) setLandmarkMarker;
-(void) setCLLocatinCoordinateObject:(double)latitude with:(double)longitude;
-(void) setlandmarkPositionString:(double)latitude and: (double) longitude;
-(id) getLandmarkPositionString;
-(id) getLandmarkMarker;
-(id) getcoordinateObject;
-(id) getTitle;

@end
