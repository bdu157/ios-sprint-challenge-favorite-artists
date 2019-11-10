//
//  ArtistFetcher.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DWPArtist;

typedef void (^ArtistFetcherCompletionHandler)(NSDictionary *artist, NSError *error);

@interface ArtistFetcher : NSObject

@property (nonatomic, readonly) NSArray<NSDictionary *> *artists;

-(void)fetchArtistWithName:(NSString *)name completion:(ArtistFetcherCompletionHandler)completionHandler;

-(void)addArtist:(NSDictionary *)aArtist;
-(void)removeArtist:(NSDictionary *)aArtist;

-(void)saveData:(NSDictionary *)aArtist;
-(void)reloadData:(NSDictionary *)aArtist;


@end

