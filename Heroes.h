//
//  Heroes.h
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Heroes : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *attributes;
@property (nonatomic) NSNumber *appearances;

+ (Heroes *)heroWithDictionary:(NSDictionary *)heroDict;

@end


