//
//  ArtistFetcher.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "ArtistFetcher.h"

static NSString *const ArtistFetcherBaseURLString = @"https://theaudiodb.com/api/";
static NSString *const APIKey = @"1";


static NSString *const ArtistFetcherFullURLString = @"https://theaudiodb.com/api/v1/json/1/search.php";
//https://www.theaudiodb.com/api/v1/json/1/search.php?s=Weezer

@interface ArtistFetcher ()

@property (nonatomic) NSMutableArray *results;

@end

@implementation ArtistFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        _results = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)fetchArtistWithName:(NSString *)name completion:(ArtistFetcherCompletionHandler)completionHandler
{
    NSLog(@"fetching started");
    
    /*
    NSString *urlString = [ArtistFetcherBaseURLString stringByAppendingPathComponent:@"v1"];
    [urlString stringByAppendingPathComponent:@"json"];
    [urlString stringByAppendingPathComponent:APIKey];
    [urlString stringByAppendingPathComponent:@"search.php"];
    */
     
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:ArtistFetcherFullURLString];
    NSMutableArray *queryItems = [NSMutableArray arrayWithObjects:[NSURLQueryItem queryItemWithName:@"s" value:name], nil];
    
    URLComponents.queryItems = queryItems;
    NSURL *URL = URLComponents.URL;
    
    //URLSession
    [[NSURLSession.sharedSession dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"URLSession started");
        
        if (error) {
            NSLog(@"Error in fetching artist: %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error);
            });
            return;
        }
        
        // testing fetching using dummyString
        /*
        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Dummy string: %@", dummyString);
        */
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding json: %@", jsonError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(jsonError);
            });
            return;
        }

        
        Artist *output = [[Artist alloc] initWithDictionary:dictionary];
        [self.results addObject:output];
        
        //paring testing
        NSLog(@"artistName: %@", [self.results[0] artistName]);
        int yearFormed = [self.results[0] yearFormed];
        NSLog(@"yearFormed: %@", [NSString stringWithFormat:@"%i", yearFormed]);
        NSLog(@"biography: %@", [self.results[0] biography]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(jsonError);
        });
        
    }] resume];
}

-(NSArray<Artist *> *)artists
{
    return self.results.copy;
}
@end
