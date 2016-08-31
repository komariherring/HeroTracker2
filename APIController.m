//
//  APIController.m
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "APIController.h"
#import <CommonCrypto/CommonDigest.h>


@interface APIController ()

@property (strong, nonatomic) NSURLSession *session;

@end

@implementation APIController

static NSString *marvelCharacterSearchUrl = @"https://gateway.marvel.com/v1/public/characters?ts=%@&name=%@&apikey=%@&hash=%@";

static NSString *publicAPIKey = @"fd590ef00b5feb622d3ab979e61ac114";
//left out private API
static NSString *privateAPIKey = @"";

+ (APIController *)sharedAPIController
{
    static APIController *sharedAPIController = nil;
    if (sharedAPIController)
        return sharedAPIController;
    
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPIController = [[APIController alloc] init];
    });
    
    return sharedAPIController;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        self.session = [NSURLSession sessionWithConfiguration:configuration];
    }
    
    return self;
}

- (void)searchForCharacter:(NSString *)characterName
{
    
    NSString *ts = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
    
    
    NSString *keysWithDateStamp = [NSString stringWithFormat:@"%@%@%@", ts, privateAPIKey, publicAPIKey];
    
    
    NSString *hash = [self md5:keysWithDateStamp];
    
    
    NSString *fullUrlString = [NSString stringWithFormat:marvelCharacterSearchUrl, ts, characterName, publicAPIKey, hash];
    NSLog(@"full URL: %@", fullUrlString);
    
    
    NSURL *url = [NSURL URLWithString:fullUrlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            NSError *parseError = nil;
            NSDictionary *characterInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            if (characterInfo)
            {
                NSLog(@"characterInfo: %@", characterInfo);
                
                [self.delegate didReceiveAPIResults:characterInfo];
            }
        }
    }];
    [dataTask resume];
}

//Stack Overflow and Greg
- (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), digest); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return  output;
}

@end
