//
//  DetailViewController.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "DetailViewController.h"
#import "DWPArtist.h"
#import "ArtistFetcher.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearFormedLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    [self updateViews];
}


#pragma mark - searchBar method

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)Save:(id)sender {
    
    
}

#pragma mark - Private Methods
-(void)updateViews
{
    if (self.artist) {
        [_nameLabel setHidden:NO];
        [_detailTextView setHidden:NO];
        [_yearFormedLabel setHidden:NO];
        self.title = self.artist.artistName;
        self.nameLabel.text = self.artist.artistName;
        self.yearFormedLabel.text = [NSString stringWithFormat:@"%@%d", @"Formed in ", self.artist.yearFormed];
        self.detailTextView.text = self.artist.biography;
    } else {
        self.title = @"Add New Artist";
        [_nameLabel setHidden:YES];
        [_detailTextView setHidden:YES];
        [_yearFormedLabel setHidden:YES];
    }
}

//setter
-(void)setArtist:(DWPArtist *)artist
{
    if (_artist != artist) {
        _artist = artist;
        [self updateViews];
    }
}
@end
