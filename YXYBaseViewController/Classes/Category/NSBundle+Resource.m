//
//  NSBundle+Resource.m
//  AFNetworking
//
//  Created by yxy on 2020/6/23.
//

#import "NSBundle+Resource.h"

@implementation NSBundle (Resource)

+ (NSBundle *)getBundle{
    NSURL *frameworkUrl = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    NSLog(@"frameworkUrl==%@", frameworkUrl);
    frameworkUrl = [frameworkUrl URLByAppendingPathComponent:@"YXYBaseViewController"];
    frameworkUrl = [frameworkUrl URLByAppendingPathExtension:@"framework"];
    if (!frameworkUrl) {
        frameworkUrl = [[NSBundle bundleForClass:NSClassFromString(@"YXYActionSheet")] URLForResource:@"YXYBaseViewController" withExtension:@"bundle"];
    }
    NSBundle *bundle;
    if (!frameworkUrl) {
        bundle = [NSBundle mainBundle];
    }else bundle = [NSBundle bundleWithURL:frameworkUrl];
    
    NSLog(@"bundle=%@", bundle);
    return bundle;
}

@end
