//
//  Asset.h
//  Stellar
//
//  Created by John Silvester on 1/11/19.
//  Copyright © 2019 John Silvester. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Asset : NSObject

@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSString *issuer;
@property(strong,nonatomic) NSString *code;
@property(nonatomic) double price;



- (id)initWithDictionary: (NSDictionary *)assetInformation;


@end

NS_ASSUME_NONNULL_END
