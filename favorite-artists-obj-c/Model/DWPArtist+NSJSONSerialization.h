//
//  DWPArtist+NSJSONSerialization.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DWPArtist.h"

@interface DWPArtist (NSJSONSerialization)

-(instancetype)initWithDictionaryFromCategory:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end


