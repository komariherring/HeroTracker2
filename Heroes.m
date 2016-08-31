//
//  Heroes.m
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "Heroes.h"

@implementation Heroes

+ (Heroes *)heroWithDictionary:(NSDictionary *)heroDict
{
    Heroes *aHero = nil;
    if (heroDict)
    {
        aHero = [[Heroes alloc] init];
        
        aHero.attributes = [heroDict objectForKey:@"attributionText"];
        
        NSDictionary *dataDict = heroDict[@"data"];
        
        NSArray *marvelArray = dataDict[@"results"];
        for (NSDictionary *result in marvelArray)
        {
            NSString *name  = result[@"name"];
            aHero.name = name;
            
            NSString *aDescription = result[@"description"];
            aHero.description = aDescription;
            
            NSDictionary *dict2 = result[@"thumbnail"];
            NSString *aPath = dict2[@"path"];
            aHero.imageName = [NSString stringWithFormat:@"%@.jpg", aPath];
            
            NSDictionary *comicsDict = result[@"comics"];
            aHero.appearances = comicsDict[@"available"];
        }
        
    }
    
    return aHero;
}

@end
