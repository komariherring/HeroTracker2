//
//  HeroesDetailViewController.m
//  HeroTracker2
//
//  Created by Komari Herring on 8/30/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "HeroesDetailViewController.h"

@interface HeroesDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *heroNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroHomeWorldLabel;
@property (weak, nonatomic) IBOutlet UILabel *heroPowersLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;

- (void)configureView;

@end

@implementation HeroesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Managing the detail view

- (void)setHero:(Heroes *)newHero
{
    if (_hero != newHero)
    {
        _hero = newHero;
        
        // Update the view.
        [self configureView];
    }
}


#pragma mark - Configure the view

- (void)configureView
{
    
    if (self.hero)
    {
        self.title = [NSString stringWithFormat: @"Hero"];
        
        self.heroNameLabel.text = self.hero.name;
        self.heroHomeWorldLabel.text = [NSString stringWithFormat: @"Appears in %@ comics", self.hero.appearances];
        self.heroPowersLabel.text = self.hero.description;
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.hero.imageName]];
        
        self.heroImageView.image = [UIImage imageWithData: imageData];
    }
}

@end
