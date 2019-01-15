//
//  APIManager.h
//  Stellar
//
//  Created by John Silvester on 1/6/19.
//  Copyright © 2019 John Silvester. All rights reserved.
//

#import <Foundation/Foundation.h>




NS_ASSUME_NONNULL_BEGIN
typedef void(^stringCompletion)(NSString *finished);
typedef void(^dictionaryCompletion)(NSDictionary *dictionary);
@interface APIManager : NSObject

@property(nonatomic,weak) NSArray *MasterIssuerList;

-(void)getPriceForKey:(NSString*)key withCompletion:(stringCompletion) completion;

-(void)getAssetsWithIssuers: (NSDictionary*)issuers withCompletion:(dictionaryCompletion) completion;

-(void)getAccountInformationForAccount: (NSString*)Account withCompletion:(dictionaryCompletion) completion;

-(NSDictionary *)returnPricingAverage: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
