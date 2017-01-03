//
//  ViewController.m
//  RSSFeed
//
//  Created by Vladysalv Vyshnevksyy on 12/6/16.
//  Copyright © 2016 Vladysalv Vyshnevksyy. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewDetailVC.h"
#import "Reachability.h"

@interface FeedViewController ()
//UI
@property (strong, nonatomic) FeedView* feedView;

//ViewModel
@property (strong, nonatomic) FeedViewModel* feedViewModel;

@property (nonatomic, copy) void (^memoryLeakBlock)();

@end

@implementation FeedViewController

#pragma mark - FeedView Delegate

-(void)userInOnlineMode:(BOOL) onlineMode {
    if (onlineMode) {
        [self.feedViewModel loadModelFromWeb];
    }
    else {
        [self.feedViewModel loadModelFromCoreData];
    }
}

-(void) cellAtRowWasSelected:(NSInteger)cell {
    FeedDetailViewModel* model = [self.feedViewModel createFeedDetailViewModelForCell:cell];
    FeedViewDetailVC* vc = [[FeedViewDetailVC alloc] initWithViewModel:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - FeedViewModel Delegate

-(void) modelWasUpdated {
    [self.feedView updateView];
}

-(void) modelFailedToUpdate {
    [self.feedView updateView];
}

#pragma mark - Create

-(FeedView*) feedView {
    if (_feedView == nil) {
        _feedView = [FeedView new];
        _feedView.translatesAutoresizingMaskIntoConstraints = NO;
        _feedView.feedViewModel = self.feedViewModel;
        _feedView.delegate = self;
    }
    return _feedView;
}

-(FeedViewModel*) feedViewModel {
    if (_feedViewModel == nil) {
        _feedViewModel = [FeedViewModel new];
        _feedViewModel.delegate = self;
    }
    return _feedViewModel;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.feedView];
    [self.feedViewModel loadModelFromWeb];
    self.navigationItem.title = NSLocalizedString(@"navigationbar.main.title", nil);
    
//    self.memoryLeakBlock = ^{
//        [self method111];
//    };
    
//    [self gggg:^int (int hh) {
//        int g = 6 + hh;
//        return g;
//    }];
}


//-(void) gggg:( int (^) (int hh) ) block {
//    int g = block(0);
//    int g1 = block(g + 6);
//}


-(void) method111 {
    NSLog(@"hi there");
}

-(void) viewDidAppear:(BOOL)animated {
    [self.feedView updateView];
}

- (void)dealloc {
    NSLog(@"dealloc vc %@", NSStringFromClass([self class]));
}
@end
