//
//  ImageViewerVC.m
//  
//
//  Created by Vladysalv Vyshnevksyy on 12/14/16.
//
//

#import "ImageViewerVC.h"
#import "Masonry.h"

@interface ImageViewerVC ()

//view
@property (strong, nonatomic) ImageViewerVCMainView* mainView;

@property (strong, nonatomic) ImageViewerViewModel* viewModel;

@end

@implementation ImageViewerVC

-(ImageViewerVCMainView*) mainView {
    if (_mainView == nil) {
        _mainView = [[ImageViewerVCMainView alloc] initWithViewModel:self.viewModel];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
        _mainView.delegate = self;
    }
    return _mainView;
}

#pragma mark - Init

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
    
    [self setConstraints];
    
    [self.view setNeedsUpdateConstraints];
}

-(void) setConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UIContentContainer protocol methods

- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.mainView toggleConstraintsForTraitCollection:newCollection];
}

#pragma mark - Actions

-(void) dismissController:(UIButton*) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Main View Delegate 

-(void) dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
