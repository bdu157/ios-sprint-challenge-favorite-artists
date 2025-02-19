//
//  ArtistFetcher.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"

typedef void (^ArtistFetcherCompletionHandler)(NSError *error);

@interface ArtistFetcher : NSObject

@property (nonatomic, readonly) NSArray<Artist *> *artists;

-(void)fetchArtistWithName:(NSString *)name completion:(ArtistFetcherCompletionHandler)completionHandler;

@end

