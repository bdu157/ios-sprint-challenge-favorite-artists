//
//  DWPArtist.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface DWPArtist : NSObject

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly, copy) NSString *artistName;

@property (nonatomic, readonly, copy) NSString *biography;

//primitive number - int
@property (nonatomic, readonly) int yearFormed;

-(instancetype)initWithDictionaryFromDWPArtist:(NSDictionary *)dictionary;

@end

