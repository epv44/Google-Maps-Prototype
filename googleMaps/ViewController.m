//
//  ViewController.m
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import "ViewController.h"
#import "Landmark.h"
#import "MDDirectionService.h"


@interface ViewController ()
    @property (strong, nonatomic) NSMutableArray *waypoints;
    @property (strong, nonatomic) NSMutableArray *waypointStrings;
    @property(strong, nonatomic) NSMutableArray *landmarksOnRoute;
@end

@implementation ViewController
Boolean noStartSet = TRUE;
CLLocationCoordinate2D startPoint;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.waypoints = [NSMutableArray array];
    self.waypointStrings = [NSMutableArray array];
    
    // Create a GMSCameraPosition that tells the map to display the coordinate at zoom level 6
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.995602
                                                            longitude:-78.902153
                                                                 zoom:13];
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.mapType = kGMSTypeHybrid;
    self.mapView.indoorEnabled = YES;
    self.mapView.accessibilityElementsHidden = NO;
    self.mapView.settings.scrollGestures = YES;
    self.mapView.settings.zoomGestures = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    self.mapView.delegate = self;
    self.view = self.mapView;
    [self updateCurrentLocation];
    [self createLandmarkObjects];
    [self loadRoute];
}

- (void)updateCurrentLocation {
    sleep(1);
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D currentLocation = [location coordinate];
    if(noStartSet){
        startPoint = currentLocation;
        noStartSet = FALSE;
    }
    [self.mapView animateToLocation:currentLocation];    
}

-(void) createLandmarkObjects{
    Landmark *fijiHouse = [[Landmark alloc] initWithTitle:@"Fiji House" latitude: 41.511217 longitude: -81.606697];
    Landmark *wadeCommons = [[Landmark alloc] initWithTitle:@"Wade Commons" latitude:41.5133020 longitude:-81.605268];
    self.landmarksOnRoute = [[NSMutableArray alloc] init];
    [self.landmarksOnRoute addObject:fijiHouse];
    [self.landmarksOnRoute addObject:wadeCommons];
}

-(void)loadRoute{
    GMSMarker *startMarker = [GMSMarker markerWithPosition:startPoint];
    [self.waypoints addObject:startMarker];
    for(Landmark *landmark in self.landmarksOnRoute){
        [self.waypoints addObject:landmark.getLandmarkMarker];
    }
    NSString *startPositionString = [NSString stringWithFormat:@"%f,%f",startPoint.latitude,startPoint.longitude];
    [self.waypointStrings addObject:startPositionString];
    for(Landmark *landmark in self.landmarksOnRoute){
        [self.waypointStrings addObject:landmark.getLandmarkPositionString];
    }
    if (self.waypoints.count > 1) {
        NSDictionary *query = @{ @"sensor" : @"false",
                                 @"waypoints" : self.waypointStrings };
        MDDirectionService *mds = [[MDDirectionService alloc] init];
        SEL selector = @selector(addDirections:);
        [mds setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    }else{
        NSLog(@"No route created, only %d", self.waypoints.count);
    }
    [self addMapAnnotation];
}
 
-(void)addDirections:(NSDictionary *)json{
    NSDictionary *routes = json[@"routes"][0];
    NSDictionary *route = routes[@"overview_polyline"];
    NSString *overview_route = route[@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.map = self.mapView;
}

-(void)addMapAnnotation{
    for(Landmark *landmark in self.landmarksOnRoute){
       GMSMarker *landmarkMarker = [GMSMarker markerWithPosition:[landmark.getcoordinateObject MKCoordinateValue]];
        landmarkMarker.title = landmark.getTitle;
        landmarkMarker.map = _mapView;
        self.view = _mapView;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
