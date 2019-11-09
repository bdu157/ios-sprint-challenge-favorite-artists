//
//  ArtistFetcher.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "ArtistFetcher.h"

static NSString *const ArtistFetcherBaseURLString = @"https://theaudiodb.com/api/";

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
    
    NSString *url = [ArtistFetcherBaseURLString stringByAppendingPathComponent:@"v1"];
    [url stringByAppendingPathComponent:@"json"];
    [url stringByAppendingPathComponent:@"1"];
    
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:url];
    NSMutableArray *queryItems = [NSMutableArray arrayWithObjects:[NSURLQueryItem queryItemWithName:@"search.php?s" value:name], nil];
    
    URLComponents.queryItems = queryItems;
    NSURL *URL = URLComponents.URL;
    
    //URLSession
}

@end
