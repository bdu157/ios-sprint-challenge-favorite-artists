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

-(DWPArtist *)dwp_changeObjecttoDictionaryWithData
{
    NSDictionary * dictionary = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingAllowFragments error:nil];
    DWPArtist * output = [[DWPArtist alloc] initWithDictionary:dictionary];
    return output;
}

@end

/*
NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
DWPArtist *output = [[DWPArtist alloc] initWithDictionary:dictionary];
*/
