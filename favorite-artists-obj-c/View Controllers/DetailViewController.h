//
//  DetailViewController.h
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArtistFetcher;
@class DWPArtist;

@interface DetailViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic) ArtistFetcher *artistFetcher;
@property (nonatomic) NSDictionary *artist;

@end

