//
//  SRPhotoBrowserController.h
//  StudioRel
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


//** this class is not used and not finished

#import "ABWebViewPlayer.h"

#define kNavBarHeight (([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) ? 44.0f : 64.0f)

//CGFloat const kNavBarHeight = 64.0f;

@interface ABWebViewPlayer()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation ABWebViewPlayer

-(void)dealloc {
    self.webView = nil;
}

- (void)parseWithCompletion:(void(^)(NSError *error))callback {
    NSAssert(self.contentURL, @"Invalid contentURL");
}


- (NSURL *)videoURL:(ABQuailityOptions)quality {
    return self.contentURL;
}

#pragma warning Move to Parent class

- (MPMoviePlayerViewController *)movieViewController:(ABQuailityOptions)quality {
    return nil;
}

- (void)playInViewController:(UIViewController *)rootViewController withQuality:(ABQuailityOptions)quality
{
    CGSize viewSize = rootViewController.view.frame.size;
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, viewSize.width, viewSize.height-kNavBarHeight)];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scalesPageToFit = YES;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(kNavBarHeight, 0, 0, 0);
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.contentURL]];
    
    self.viewController = [UIViewController new];
    self.viewController.view = self.webView;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, viewSize.width, kNavBarHeight)];
    UINavigationItem *navItem=[[UINavigationItem alloc] init];
    navItem.leftBarButtonItems = @[[[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                    target:self
                                    action:@selector(dismiss)]];
    navBar.items = @[navItem];
    [self.webView addSubview:navBar];

    [rootViewController presentViewController:self.viewController animated:YES completion:^{
    }];
}


- (void)play:(ABQuailityOptions)quality {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self playInViewController:rootViewController withQuality:quality];
}

- (void)dismiss {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
}

@end
