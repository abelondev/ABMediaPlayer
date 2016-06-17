//
//
//  Created by Andrey Belonogov on 9/5/15.
//
//

#import <Foundation/Foundation.h>
#import "ABMediaHandler.h"

@interface ABMediaHandler()
@property (nonatomic, strong) MPMoviePlayerViewController *player;
@end

@implementation ABMediaHandler

- (instancetype)initWithContent:(NSURL *)contentURL {
    self = [super init];
    if (self) {
        self.contentURL = contentURL;
    }
    return self;
}

- (MPMoviePlayerViewController *)movieViewController:(ABQuailityOptions)quality {
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:[self videoURL:quality]];
    [self.player.moviePlayer setShouldAutoplay:YES];
    [self.player.moviePlayer prepareToPlay];
    
    return self.player;
}

- (void)play:(ABQuailityOptions)quality {
    if (!self.player)
        [self movieViewController:quality];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:self.player];
    [self.player.moviePlayer play];
}

- (void)playInViewController:(UIViewController *)viewController withQuality:(ABQuailityOptions)quality
{
    if (!self.player)
        [self movieViewController:quality];
    [viewController presentMoviePlayerViewControllerAnimated:self.player];
    [self.player.moviePlayer play];
}

- (void)parseWithCompletion:(void(^)(NSError *error))callback {
    NSAssert(NO, @"this method must be implemented in subclass");
}

- (NSURL *)videoURL:(ABQuailityOptions)quality {
    NSAssert(NO, @"this method must be implemented in subclass");
    return nil;
}


@end
