//
//  DWPArtist+NSJSONSerialization.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DWPArtist+NSJSONSerialization.h"
#import "DWPArtist.h"

@implementation DWPArtist (NSJSONSerialization)

-(instancetype)initWithDictionaryFromCategory:(NSDictionary *)dictionary;
{
    DWPArtist *artist = [[DWPArtist alloc] initWithDictionary:dictionary];
    return artist;
}


//this will bring dictionary format of DWPArtist
-(NSDictionary *)toDictionary
{
    return @{@"strArtist": self.artistName, @"strBiographyEN": self.biography, @"intFormedYear": [[NSNumber alloc] initWithInt: self.yearFormed]};
}
@end

/*
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
DWPArtist *output = [[DWPArtist alloc] initWithDictionary:dictionary];
*/
