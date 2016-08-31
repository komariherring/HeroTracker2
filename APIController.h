//
//  APIController.h
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeroesTableViewController.h"

@interface APIController : NSObject

@property (strong, nonatomic) id<APIControllerProtocol> delegate;


// from Greg
+ (APIController *)sharedAPIController;
- (void)searchForCharacter:(NSString *)characterName;





@end
