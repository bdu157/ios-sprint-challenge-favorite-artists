//
//  ArtistFetcher.m
//  favorite-artists-obj-c
//
//  Created by Dongwoo Pae on 11/9/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

#import "ArtistFetcher.h"
#import "DWPArtist.h"
#import "DWPArtist+NSJSONSerialization.h"

static NSString *const ArtistFetcherBaseURLString = @"https://theaudiodb.com/api/";
static NSString *const APIKey = @"1";


static NSString *const ArtistFetcherFullURLString = @"https://theaudiodb.com/api/v1/json/1/search.php";
//https://www.theaudiodb.com/api/v1/json/1/search.php?s=Weezer

@interface ArtistFetcher ()

@property (nonatomic) NSMutableArray *results;

@end

@implementation ArtistFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        _results = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)fetchArtistWithName:(NSString *)name completion:(ArtistFetcherCompletionHandler)completionHandler
{
    NSLog(@"fetching started");
    
    /*
     NSString *urlString = [ArtistFetcherBaseURLString stringByAppendingPathComponent:@"v1"];
     [urlString stringByAppendingPathComponent:@"json"];
     [urlString stringByAppendingPathComponent:APIKey];
     [urlString stringByAppendingPathComponent:@"search.php"];
     */
    
    NSURLComponents *URLComponents = [[NSURLComponents alloc] initWithString:ArtistFetcherFullURLString];
    NSMutableArray *queryItems = [NSMutableArray arrayWithObjects:[NSURLQueryItem queryItemWithName:@"s" value:name], nil];
    
    URLComponents.queryItems = queryItems;
    NSURL *URL = URLComponents.URL;
    
    //URLSession
    [[NSURLSession.sharedSession dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSLog(@"URLSession started");
        
        if (error) {
            NSLog(@"Error in fetching artist: %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            return;
        }
        
        // testing fetching using dummyString
        /*
         NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"Dummy string: %@", dummyString);
         */
        
        NSError *jsonError = nil;
        
        //replacing this part with category
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding json: %@", jsonError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, jsonError);
            });
            return;
        }
        
        NSDictionary *output = [[DWPArtist
                                 alloc]initWithDictionaryFromCategory:dictionary].toDictionary;
        
        //paring testing with output
        NSLog(@"artistName: %@", [output objectForKey:@"strArtist"]);
        NSLog(@"yearFormed: %@", [output objectForKey:@"yearFormed"]);
        NSLog(@"biography: %@", [output objectForKey:@"strBiographyEN"]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(output, jsonError); //this is dictionary but i am passing DWPArtist
        });
        
    }] resume];
}

//add
-(void)addArtist:(NSDictionary *)aArtist
{
    [self.results addObject:aArtist];
    [self saveData];
}

//remove
-(void)removeArtist:(NSDictionary *)aArtist
{
    [self.results removeObject:aArtist];
    [self saveData];
}

//fileManager for saving and reloading the data
-(void)saveData
{
    NSLog(@"Saving data");
    NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"results.plist"];
    
    NSMutableArray *artistDictionaries = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dictionary in self.results) {
        [artistDictionaries addObject:dictionary];
    }
    [artistDictionaries writeToURL:documentDirectory atomically:YES];

    //try using NSData so change an array of DWPArtist dictionaries to NSData and save it into results.plist
    
    
}

//Q : what is benefit of saving data as an array of dictionaries format instead of array of DWPArist format?????

-(void)loadData;
{
    NSLog(@"Loadig data");
    //when fetching the data, it turns into dictionary and adds into an array and they get handled in tableView as an array of ditionary format instead of DWPArtist format
    //so when you load savedData, you just need to add these datas back into results array, which is an array of NSDictionaries since they get handled as in dictionary format not in DWPArtist format
    //Alternatively, you can just change DWPArtst format into toDictionary when saving it through fileManager and change the array of dictionaries to DWPArtist format when loading them to show in mainTableView controller if you choose to use DWPArtist format in mainTalbeView and you fetch DWPArtist format from the JSON file
    NSURL *documentDirectory = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:@"results.plist"];
    
    NSMutableArray *artistDictionaries = [[NSMutableArray alloc] initWithContentsOfURL:documentDirectory];
    
    for (NSDictionary *artist in artistDictionaries) {
        [self.results addObject:artist];
    }
}

-(NSArray<NSDictionary *> *)artists
{
    return self.results.copy;
}
@end
