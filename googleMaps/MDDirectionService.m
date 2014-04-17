//
//  MDDirectionService.m
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  This code is based directly from provided documentation in the google api documents
//  And tutorial section.  Can find sources on the google maps API direction services
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import "MDDirectionService.h"

@interface MDDirectionService()
@property (assign, nonatomic) BOOL sensor;
@property (assign, nonatomic) BOOL alternatives;
@property (strong, nonatomic) NSURL *directionsURL;
@property (strong, nonatomic) NSArray *waypoints;
@end

@implementation MDDirectionService

static NSString *kMDDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";

- (void)setDirectionsQuery:(NSDictionary *)query
              withSelector:(SEL)selector
              withDelegate:(id)delegate
{
    NSArray *waypoints = query[@"waypoints"];
    NSString *origin = waypoints[0];
    int waypointCount = [waypoints count];
    int destinationPos = waypointCount - 1;
    NSString *destination = waypoints[destinationPos];
    NSString *sensor = query[@"sensor"];
    NSMutableString *url =
    [NSMutableString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@",
     kMDDirectionsURL, origin, destination, sensor];
    if(waypointCount > 2) {
        [url appendString:@"&waypoints=optimize:true"];
        int wpCount = waypointCount-2;
        for(int i=1;i<wpCount;i++){
            [url appendString: @"|"];
            [url appendString:[waypoints objectAtIndex:i]];
        }
    }
    
    [url appendString:@"&mode=walking"];
    
    url = [[url
            stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding] mutableCopy];
    _directionsURL = [NSURL URLWithString:url];
    [self retrieveDirections:selector
                withDelegate:delegate];
}

- (void)retrieveDirections:(SEL)selector
              withDelegate:(id)delegate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data = [NSData dataWithContentsOfURL:_directionsURL];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
}

- (void)fetchedData:(NSData *)data
       withSelector:(SEL)selector
       withDelegate:(id)delegate
{
    
    NSError* error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:data
                          options:kNilOptions
                          error:&error];
    [delegate performSelector:selector
                   withObject:json];
}

@end
