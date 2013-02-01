//
//  ShareTokensCollectionViewController.m
//  Dispenser
//
//  Created by Alaric Cole on 1/30/13.
//  Copyright (c) 2013 Alaric. All rights reserved.
//

#import "ShareTokensCollectionViewController.h"

@interface ShareTokensCollectionViewController ()

@end

@implementation ShareTokensCollectionViewController

- (IBAction)showSharingOptions:(id)sender {


	NSArray * selectedItems = [self.collectionView indexPathsForSelectedItems];


	NSMutableArray * tokenURLs = [NSMutableArray array];

	if (selectedItems.count > 0) {

		for (NSIndexPath * indexPath in selectedItems) {

			NSString * tokenString = self.availableTokensArray[indexPath.item];


			[tokenURLs addObject:tokenString];
		}


		NSString * initialPrompt = @"Here's your token(s) for Process."	;

		NSString * finalPrompt = @"Be sure to also check out the next big thing: gistapp.com"	;



		NSMutableArray *itemsForSharing = [NSMutableArray array];

		[itemsForSharing addObject:initialPrompt];
		[itemsForSharing addObject:finalPrompt];

		[itemsForSharing addObjectsFromArray:tokenURLs];


		UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:itemsForSharing applicationActivities: nil];


		activityController.excludedActivityTypes = @[
		//UIActivityTypeCopyToPasteboard, //Note that copying will call the completion handler with completedSuccessfully=YES, and tokens will be removed
		UIActivityTypeAssignToContact,
		//You probably don't want to post individual-specific codes to public places.
		//Plus, these services won't work well with multiple URLs.
		//Facebook is ok with 'http://' strings, but Twitter will ignore them unless in an NSURL
		///*
		 UIActivityTypePostToFacebook,
		 UIActivityTypePostToTwitter,
		 UIActivityTypePostToWeibo,

		// */

		//UIActivityTypeSaveToCameraRoll, //not necessary to add these as we're dealing with text
		//UIActivityTypePrint
		];

		activityController.completionHandler = ^(NSString *activityType, BOOL completedSuccessfully)
		{

			if (completedSuccessfully) {
				//mark token as used, remove it from this list and add it to the dispensed list

				NSArray * selectedItems = [self.collectionView indexPathsForSelectedItems];


				
					//could just call reloadData, but animations help show what happened
					[self.collectionView performBatchUpdates:^{
						//[self.collectionView deleteItemsAtIndexPaths:selectedItems];

						//enumerating over the indexPathsForSelectedItems may change it and cause problems.
						[selectedItems enumerateObjectsUsingBlock:^(NSIndexPath* indexPath, NSUInteger idx, BOOL *stop) {

//							NSLog(@"item at %@", indexPath.description);

							NSString * token = [self.availableTokensArray objectAtIndex:indexPath.item];
							
							[self.availableTokensArray removeObject:token];

							
							NSInteger itemsInsSection = [self collectionView:self.collectionView numberOfItemsInSection:1];

//							NSLog(@"token: %@", token);

							NSIndexPath * finalIndexPath = [NSIndexPath indexPathForItem:itemsInsSection inSection:1];

//							NSString * user = @"some user";
//							NSDictionary * dispensedTokenDictionary = @{ @"token": token, @"user": user};
//							[self.dispensedTokensArray addObject:dispensedTokenDictionary];
//							tokenString = dispensedTokenDictionary[ @"tokens" ];
							
							[self.dispensedTokensArray addObject:token];
							
							[self.collectionView deselectItemAtIndexPath:indexPath animated:NO];

							TokenCollectionViewCell * cell = (TokenCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:indexPath];

							cell.isDispensed = YES;


							[self.collectionView moveItemAtIndexPath:indexPath toIndexPath:finalIndexPath];
							
						}];
						
						} completion:^(BOOL finished) {

							//save for later
							[[NSUserDefaults standardUserDefaults] setObject:self.availableTokensArray forKey:kAvailableTokensArray];

							[[NSUserDefaults standardUserDefaults] setObject:self.dispensedTokensArray forKey:kDispensedTokensArray];


							[[NSUserDefaults standardUserDefaults] synchronize];
							


					}];
				}
			
		};




		[self presentViewController:activityController animated:YES completion:^{

			//Nice job sharing those tokens.
		}];


	}


}


#pragma mark segue
- (IBAction)cancel:(UIStoryboardSegue *)segue
{
	//just unwind
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
	AddTokensViewController* sourceViewController = (AddTokensViewController*) segue.sourceViewController;

	NSString * tokensString = sourceViewController.textView.text;

	NSArray * tokensArray;
	
	//if (tokensString.length > 0)
	{
		tokensArray = [tokensString componentsSeparatedByString:@"\n"];//you may wish to choose a comma here, etc.
	}
//else
	{
		//clear all tokens

		
	}

	self.availableTokensArray = tokensArray.mutableCopy;

	self.dispensedTokensArray = [NSMutableArray array];

	[self.collectionView reloadData];

	[[NSUserDefaults standardUserDefaults] setObject:self.availableTokensArray forKey:kAvailableTokensArray];

	[[NSUserDefaults standardUserDefaults] setObject:self.dispensedTokensArray forKey:kDispensedTokensArray];


	[[NSUserDefaults standardUserDefaults] synchronize];


}

#pragma mark view lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];

	self.collectionView.allowsMultipleSelection = YES;

	//load previous tokens, if any
	NSArray * storedAvailableTokens = [[NSUserDefaults standardUserDefaults] objectForKey:kAvailableTokensArray];

	NSArray * storedDispensedTokens = [[NSUserDefaults standardUserDefaults] objectForKey:kDispensedTokensArray];

	self.availableTokensArray = storedAvailableTokens.mutableCopy;

	self.dispensedTokensArray = storedDispensedTokens.mutableCopy;

}

-(void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];

#if ! SCREENSHOT
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		if (self.availableTokensArray.count == 0 && self.dispensedTokensArray.count == 0) {

			//show the Add Tokens screen if we don't have any tokens yet

			[self performSegueWithIdentifier:@"addTokensSegue" sender:self];
		}

	});

#else

	[UIApplication sharedApplication ].statusBarHidden = YES;

#endif
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(NSString*)selectedItemsTitle
{
	return [NSString stringWithFormat:@"%i of %i %@", self.collectionView.indexPathsForSelectedItems.count, self.availableTokensArray.count,  NSLocalizedString(@"Selected", nil)];

}

#pragma mark Collection View



-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		return NO;
	}
	return YES;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1) {
		return NO;
	}
	return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 2;


}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
	if (section == 1) {
		return self.dispensedTokensArray.count;
	}

	return self.availableTokensArray.count;

}

//add headers or footers here if you want to support sections/groupings of tokens
/*
 - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 if ([kind isEqualToString:UICollectionElementKindSectionFooter])
 {
 return nil;
 }

 else if	([kind isEqualToString:UICollectionElementKindSectionHeader])
 {
 return nil;
 }

 return nil;
 }
 */

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{

	TokenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TOKEN_CELL" forIndexPath:indexPath];

	cell.isEditing = YES;

	NSString * tokenString;
	
	if (indexPath.section == 1) {

//		NSDictionary * dispensedTokenDictionary = self.dispensedTokensArray[indexPath.item];
//		
//		tokenString = dispensedTokenDictionary[ @"tokens" ];

		tokenString = self.dispensedTokensArray[indexPath.item];
		
		cell.isDispensed = YES;

		cell.subtitleLabel.text = @"";//user
	}
	else
	{
		tokenString = self.availableTokensArray[indexPath.item];

		cell.isDispensed = NO;

		cell.subtitleLabel.text = @"";
	}

	//I like to strip the url prefix to make it look nice.
	NSString * urlPrefix = kURLPrefix;

	NSArray * brokenLinks = [tokenString.lowercaseString componentsSeparatedByString:urlPrefix.lowercaseString];

	NSString * shortenedLink = tokenString;

	if (brokenLinks.count > 1) {
		shortenedLink = brokenLinks[1];
		shortenedLink = shortenedLink.uppercaseString;

	}

	cell.label.text = shortenedLink;


	return cell;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

	self.title = [self selectedItemsTitle];

	self.actionButton.enabled = (self.collectionView.indexPathsForSelectedItems.count > 0);

}
- (void) collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
	self.title = [self selectedItemsTitle];
	
	self.actionButton.enabled = (self.collectionView.indexPathsForSelectedItems.count > 0);
	
}


@end
