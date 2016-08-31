//
//  HeroesTableViewController.m
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "HeroesTableViewController.h"
#import "HeroesDetailViewController.h"
#import "Heroes.h"
#import "APIController.h"

@interface HeroesTableViewController () <APIControllerProtocol, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@property NSMutableArray *heroes;

@end

@implementation HeroesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    self.heroes = [[NSMutableArray alloc] init];

    
}

#pragma mark -

- (void)loadHeroes
{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"heroes" ofType:@"json"];

    NSDictionary *heroesDictForJSON = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    
    if (heroesDictForJSON)
    {
        Hero *aHero = [Hero heroWithDictionary:heroesDictForJSON];
        [self.heroes addObject:aHero];
    }
    
    [self.tableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.heroes.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroCell" forIndexPath:indexPath];
    
    Hero *aHero = self.heroes[indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = aHero.name;
    cell.detailTextLabel.text = aHero.attributes;
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HeroesDetailViewController *newHeroVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HeroDetailVC"];
    [[self navigationController] pushViewController:newHeroVC animated:YES];
    
    Hero *selectedHero = self.heroes[indexPath.row];
    newHeroVC.hero = selectedHero;
    
}

-(void)didReceiveAPIResults:(NSDictionary *)gitHubResponse
{
    Hero *aHero = [Hero heroWithDictionary:gitHubResponse];
    [self.heroes addObject:aHero];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

#pragma mark - Search bar method

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    
    if ([self.mySearchBar.text  isEqual: @""])
    {
        return;
    }
    [self doSearch:self.mySearchBar.text];
    
}

#pragma mark - Using api inside of a custom search method

-(void)doSearch:(NSString *)searchThisMarvel
{
    [self.mySearchBar resignFirstResponder];
    APIController *apiController = [APIController sharedAPIController];
    apiController.delegate = self;
    [apiController searchForCharacter:searchThisMarvel];
    self.mySearchBar.text = @"";

    
}

#pragma mark - Cancel button to resign typing

- (IBAction)cancelTapped:(UIBarButtonItem *)sender
{
    [self.mySearchBar resignFirstResponder];
    self.mySearchBar.text = @"";
}

// One tiny change

@end
