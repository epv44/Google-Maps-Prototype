//
//  MDDirectionService.h
//  googleMaps
//
//  Created by Eric Vennaro on 3/23/14.
//  Copyright (c) 2014 Eric Vennaro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDDirectionService : NSObject
- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector
              withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSData *)data withSelector:(SEL)selector
       withDelegate:(id)delegate;
@end
