//
//  Landmark.m
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import "Landmark.h"
@implementation Landmark
@synthesize title, landmarkMarker, landmarkPositionString, coordinate;

-(id) initWithTitle: (NSString *) landmarkTitle latitude: (double) lat longitude: (double) lon {
    self = [super init];
    if(self){
        title = landmarkTitle;
        [self setCLLocatinCoordinateObject:lat with:lon];
        [self setLandmarkMarker];
        [self setlandmarkPositionString:(double) lat and:(double) lon];

    }
    return self;
}

-(void) setLandmarkMarker{
    landmarkMarker = [GMSMarker markerWithPosition:[coordinate MKCoordinateValue]];
}
-(void) setCLLocatinCoordinateObject:(double)latitude with:(double)longitude{
    CLLocationCoordinate2D newCoord = CLLocationCoordinate2DMake(latitude, longitude);
    coordinate = [NSValue valueWithMKCoordinate:newCoord];
}
-(void) setlandmarkPositionString:(double)latitude and: (double) longitude{
    landmarkPositionString = [NSString stringWithFormat:@"%f, %f", latitude,longitude];
}
-(id) getTitle{
    return title;
}

-(id) getLandmarkMarker{
    return landmarkMarker;
}

-(id) getcoordinateObject{
    return coordinate;
}

-(id) getLandmarkPositionString{
    return landmarkPositionString;
}


@end
