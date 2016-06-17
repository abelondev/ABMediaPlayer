//
//
//  Created by Andrey Belonogov on 8/27/15.
//  Copyright © 2015 studiorel. All rights reserved.
//


#import "ABFilePlayer.h"

@implementation ABFilePlayer

- (void)parseWithCompletion:(void(^)(NSError *error))callback {
    if (callback) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(nil);
        });
    }
}

- (NSURL *)videoURL:(ABQuailityOptions)quality {
    return self.contentURL;
}

- (MPMoviePlayerViewController *)movieViewController:(ABQuailityOptions)quality {
    MPMoviePlayerViewController *player = [super movieViewController:quality];
    player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    return player;
}

@end
