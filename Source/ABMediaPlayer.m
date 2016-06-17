//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import "ABMediaPlayer.h"

NSString *const kVideoNotSupported = @"Video not supported";

@interface ABMediaPlayer()
@property (nonatomic, strong) MPMoviePlayerViewController *player;
@property (nonatomic, strong) ABMediaHandler *video;
@property (nonatomic) ABMediaType videoType;
@end

@implementation ABMediaPlayer

- (instancetype)initWithURL:(NSURL *)contentURL {
    self = [super init];
    if (self) {
        self.contentURL = contentURL;
    }
    return self;
}

- (void)parseWithCompletion:(void(^)(ABMediaType, ABMediaHandler *, NSError *))callback {
    ABMediaType videoType = [self videoType];
    switch (videoType) {
        case ABMediaTypeYouTube:
            self.video = [[ABYoutubePlayer alloc] initWithContent:self.contentURL];
            break;
            
        case ABMediaTypeVimeo:
            self.video = [[ABVimeoPlayer alloc] initWithContent:self.contentURL];
            break;
            
        case ABMediaTypeFile:
            self.video = [[ABFilePlayer alloc] initWithContent:self.contentURL];
            break;

       // case ABMediaTypeWebView:
       //     self.video = [[ABWebViewPlayer alloc] initWithContent:self.contentURL];
       //     break;
    }
    
    [self.video parseWithCompletion:^(NSError *error) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(videoType, _video, nil);
            });
        }
    }];
}

- (MPMoviePlayerViewController *)movieViewController:(ABQuailityOptions)quality {
    self.player = [[MPMoviePlayerViewController alloc] initWithContentURL:self.contentURL];
    [self.player.moviePlayer setShouldAutoplay:NO];
    [self.player.moviePlayer prepareToPlay];
    
    return self.player;
}

- (void)play:(ABQuailityOptions)quality {
    if (!self.player) [self movieViewController:quality];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:self.player];
    [self.player.moviePlayer play];
}

+ (void)parse:(NSURL *)contentURL completion:(void(^)(ABMediaType, ABMediaHandler *, NSError *))callback {
    ABMediaPlayer *playerKit = [[ABMediaPlayer alloc] initWithURL:contentURL];
    
    [playerKit parseWithCompletion:^(ABMediaType videoType, ABMediaHandler *video, NSError *error) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(videoType, video, error);
            });
        }
    }];
}

- (ABMediaType)videoType {
    NSString *strURL = self.contentURL.absoluteString;
    if ([strURL hasPrefix:@"assets-library://"] && [strURL hasSuffix:@"&ext=MOV"]) {
        return ABMediaTypeFile;
    } else if ([self.contentURL.host.lowercaseString hasSuffix:@"youtube.com"] || [self.contentURL.host.lowercaseString hasSuffix:@"youtu.be"]) {
        return ABMediaTypeYouTube;
    } else if ([self.contentURL.host.lowercaseString hasSuffix:@"vimeo.com"]) {
        return ABMediaTypeVimeo;
    } else {
        return ABMediaTypeFile;
    }
}

- (void)playInViewController:(UIViewController *)rootViewController withQuality:(ABQuailityOptions)quality {
    [self parseWithCompletion:^(ABMediaType videoType, ABMediaHandler *video, NSError *error) {
        _video=video;
        [_video playInViewController:rootViewController withQuality:ABQuailityMedium];
    }];
}
@end
