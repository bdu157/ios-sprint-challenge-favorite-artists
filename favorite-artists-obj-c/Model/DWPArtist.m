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
        
        _yearFormed = (int) artists[0][@"intFormedYear"];
        
        _biography = artists[0][@"strBiographyEN"];
    }
    return self;
}

@end
