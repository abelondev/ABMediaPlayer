//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSUInteger, ABQuailityOptions) {
    ABQuailityLow,
    ABQuailityMedium,
    ABQuailityHigh
};

@interface ABMediaHandler : NSObject
@property (nonatomic, strong) NSURL *contentURL;

- (instancetype)initWithContent:(NSURL *)contentURL;
- (void)parseWithCompletion:(void(^)(NSError *error))callback;
- (NSURL *)videoURL:(ABQuailityOptions)quality;
- (void)playInViewController:(UIViewController *)viewController withQuality:(ABQuailityOptions)quality;
- (MPMoviePlayerViewController *)movieViewController:(ABQuailityOptions)quality;
                                                       
@end
