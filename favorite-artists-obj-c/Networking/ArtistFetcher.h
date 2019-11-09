//
//  ArtistFetcher.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DWPArtist;

typedef void (^ArtistFetcherCompletionHandler)(DWPArtist *artist, NSError *error);

@interface ArtistFetcher : NSObject

@property (nonatomic, readonly) NSArray<DWPArtist *> *artists;

-(void)fetchArtistWithName:(NSString *)name completion:(ArtistFetcherCompletionHandler)completionHandler;


-(void)addArtist:(DWPArtist *)aArtist;
-(void)removeArtist:(DWPArtist *)aArtist;
@end

