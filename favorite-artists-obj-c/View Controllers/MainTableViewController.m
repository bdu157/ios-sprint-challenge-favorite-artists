//
//  MainTableViewController.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "MainTableViewController.h"
#import "ArtistFetcher.h"
#import "DWPArtist.h"
#import "DetailViewController.h"

@interface MainTableViewController ()

@property ArtistFetcher *artistFetcher;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _artistFetcher = [[ArtistFetcher alloc] init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _artistFetcher.artists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    DWPArtist *artist = [self.artistFetcher.artists objectAtIndex:indexPath.row];
    cell.textLabel.text = artist.artistName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%d", @"Formed in ", artist.yearFormed];
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DWPArtist *artist = [self.artistFetcher.artists objectAtIndex:indexPath.row];
        [self.artistFetcher removeArtist:artist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ToViewDetail"]) {
           NSIndexPath *selectedRow = self.tableView.indexPathForSelectedRow;
           DetailViewController *detailVC = segue.destinationViewController;
           detailVC.artistFetcher = self.artistFetcher;
           detailVC.artist = [self.artistFetcher.artists objectAtIndex:selectedRow.row];
       } else if ([segue.identifier isEqualToString:@"ToSearchArtist"]) {
           DetailViewController *detailVC = segue.destinationViewController;
           detailVC.artistFetcher = self.artistFetcher;
       }
}


@end
