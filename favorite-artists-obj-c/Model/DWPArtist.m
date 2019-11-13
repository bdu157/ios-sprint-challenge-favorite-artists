//
//  DWPArtist.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DWPArtist.h"

@implementation DWPArtist

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        //parsing
        NSArray *artists = [dictionary objectForKey:@"artists"];
        _artistName = artists[0][@"strArtist"];

        _yearFormed = [artists[0][@"intFormedYear"] intValue];

        _biography = artists[0][@"strBiographyEN"];
        
        
    }
    return self;
}

#pragma mark -  this will be used to change customed dictionary format into DWPArtist format after bringing save datas from persistent store

-(instancetype)initWithDictionaryFromDWPArtist:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
    
        _artistName = dictionary[@"strArtist"];

        _yearFormed = [dictionary[@"intFormedYear"] intValue];

        _biography = dictionary[@"strBiographyEN"];
    }
    return self;
}

@end
