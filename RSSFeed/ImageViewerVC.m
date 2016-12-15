//
//  ImageViewerVC.m
//  
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//
//

#import "ImageViewerVC.h"
#import "ImageViewerVCMainView.h"
#import "Masonry.h"

@interface ImageViewerVC ()

//view
@property (strong, nonatomic) ImageViewerVCMainView* mainView;

@property (strong, nonatomic) ImageViewerViewModel* viewModel;


@end

@implementation ImageViewerVC

UIButton* button;

-(ImageViewerVCMainView*) mainView {
    if (_mainView == nil) {
        _mainView = [[ImageViewerVCMainView alloc] initWithViewModel:self.viewModel];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}

- (instancetype)initWithViewModel:(ImageViewerViewModel*) viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainView];

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 100, 100);
    [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.mainView addSubview:button];
    
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
//    UIVisualEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView * blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    blurEffectView.frame = self.view.frame;
//    [self.view addSubview:blurEffectView];
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark - Actions

-(void) tap:(UIButton*) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
