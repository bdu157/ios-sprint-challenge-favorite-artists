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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateViews];
}


#pragma mark - searchBar method

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *artistName = [self.searchBar text];
    
    [_artistFetcher fetchArtistWithName:artistName completion:^(DWPArtist *artist, NSError *error) {
        if (error) {
            NSLog(@"Error fetching artist: %@", error);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.artist = artist;
            [self updateViews];
            [self.saveButton setEnabled:true];
        });
    }];
    
}

- (IBAction)Save:(id)sender {
    BOOL isNewArtist = (self.artist != nil);
    
    if (isNewArtist) {
        
        [self.artistFetcher addArtist:self.artist];
    } else {
        NSLog(@"No artist being saved");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private Methods
-(void)updateViews
{
    if (self.artist) {
        [_nameLabel setHidden:NO];
        [_detailTextView setHidden:NO];
        [_yearFormedLabel setHidden:NO];
        self.title = [self.artist artistName];
        self.nameLabel.text = [self.artist artistName];
        self.yearFormedLabel.text = [NSString stringWithFormat:@"%@%d", @"Formed in " ,[self.artist yearFormed]];
        self.detailTextView.text = [self.artist biography];
        [_saveButton setEnabled:false];
    } else {
        self.title = @"Add New Artist";
        [_nameLabel setHidden:YES];
        [_detailTextView setHidden:YES];
        [_yearFormedLabel setHidden:YES];
        [_saveButton setEnabled:true];
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
