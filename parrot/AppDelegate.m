//
//  AppDelegate.m
//  parrot
//
//  Created by xiaoyi on 15/11/12.
//  Copyright © 2015年 taihuoniao. All rights reserved.
//

#import "AppDelegate.h"

#import "FBConfig.h"
#import "FBMainViewController.h"
#import "FBCategoryViewController.h"
#import "FBFindViewController.h"
#import "FBTrialViewController.h"
#import "FBAccountViewController.h"

@interface AppDelegate () {
    UINavigationController *_mainNC;
    UINavigationController *_categoryNC;
    UINavigationController *_findNC;
    UINavigationController *_trialNC;
    UINavigationController *_accountNC;
}

@property (nonatomic, strong) FBMainViewController *mainViewController;
@property (nonatomic, strong) FBCategoryViewController *categoryViewController;
@property (nonatomic, strong) FBFindViewController *findViewController;
@property (nonatomic, strong) FBTrialViewController *trialViewController;
@property (nonatomic, strong) FBAccountViewController *accountViewController;

@end

@implementation AppDelegate

@synthesize window = _window;

@synthesize mainViewController = _mainViewController, categoryViewController = _categoryViewController, findViewController = _findViewController, trialViewController = _trialViewController, accountViewController = _accountViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:kFontFamily size:12.0f],
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:kFontFamily size:12.0f],
                                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                                        } forState:UIControlStateSelected];
    UIColor *mangetaColor = [UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:mangetaColor, NSForegroundColorAttributeName, [UIFont fontWithName:kFontFamily size:18.0f], NSFontAttributeName, nil];
    
    
    // 添加导航栏
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.tabBar.translucent = false;
    self.window.rootViewController = tabBar;
    
    // 生成RootViewController
    _mainViewController     = [[FBMainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    _categoryViewController = [[FBCategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    _findViewController     = [[FBFindViewController alloc] init];
    _trialViewController    = [[FBTrialViewController alloc] init];
    _accountViewController  = [[FBAccountViewController alloc] init];
    
    // ----------------------------创建Tab导航栏--------------------------------
    // 精选集
    _mainNC = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
    _mainNC.delegate = self;
    _mainNC.tabBarItem.title = @"精选";
    _mainNC.tabBarItem.image = [[UIImage imageNamed:@"icon_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _mainNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_home_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_mainNC.navigationBar setTitleTextAttributes:attributes];
    
    [tabBar addChildViewController:_mainNC];
    
    // 品类
    _categoryNC = [[UINavigationController alloc] initWithRootViewController:_categoryViewController];
    _categoryNC.delegate = self;
    _categoryNC.tabBarItem.title = @"好货";
    _categoryNC.tabBarItem.image = [[UIImage imageNamed:@"icon_shopping_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _categoryNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_shopping_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_categoryNC.navigationBar setTitleTextAttributes:attributes];
    
    [tabBar addChildViewController:_categoryNC];
    
    
    // 发现
    _findNC = [[UINavigationController alloc] initWithRootViewController:_findViewController];
    _findNC.delegate = self;
    _findNC.tabBarItem.title = @"发现";
    _findNC.tabBarItem.image = [[UIImage imageNamed:@"icon_cart_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _findNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_cart_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_findNC.navigationBar setTitleTextAttributes:attributes];
    
    [tabBar addChildViewController:_findNC];
    
    // 试用
    _trialNC = [[UINavigationController alloc] initWithRootViewController:_trialViewController];
    _trialNC.delegate = self;
    _trialNC.tabBarItem.title = @"试用";
    _trialNC.tabBarItem.image = [[UIImage imageNamed:@"icon_cart_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _trialNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_cart_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_trialNC.navigationBar setTitleTextAttributes:attributes];
    
    [tabBar addChildViewController:_trialNC];
    
    // 我的账户
    _accountNC = [[UINavigationController alloc] initWithRootViewController:_accountViewController];
    _accountNC.delegate = self;
    _accountNC.tabBarItem.title = @"我的";
    _accountNC.tabBarItem.image = [[UIImage imageNamed:@"icon_users_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _accountNC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_users_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [_accountNC.navigationBar setTitleTextAttributes:attributes];
    
    [tabBar addChildViewController:_accountNC];
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.taihuoniao.parrot" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"parrot" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"parrot.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
