

#import "AppDelegate.h"
#import "ViewController.h"
#import "RTNetworking.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadNetWork];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)loadNetWork{
    [RTNetworking updateBaseUrl:@"https://api.shunliandongli.com"];
    [RTNetworking enableInterfaceDebug:NO];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"ShunLian iPhone 9.3.2/1.0.0" , @"User-Agent",
                         @"C51FEB80-6323-4676-BA4B-A3135B4810E3" , @"X-Device-ID",
                         @"gzip, deflate" , @"Accept-Encoding",
                         @"192.168.31.121" , @"X-Ip",
                         @"application/json" , @"Content-Type",
                         nil];
    
    [RTNetworking configCommonHttpHeaders:dic];
    
    [RTNetworking configRequestType:kRTRequestTypePlainText
                       responseType:RTResponseTypeData
                shouldAutoEncodeUrl:YES
            callbackOnCancelRequest:NO];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
