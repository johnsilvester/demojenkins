//
//  ViewController.m
//  Stellar
//
//  Created by John Silvester on 1/4/19.
//  Copyright © 2019 John Silvester. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *cryptoPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cryptoNameLabel;
@property (nonatomic, strong) NSDictionary *currencyDictionary;

@end



@implementation ViewController

- (void)viewDidLoad {
    self.currencyDictionary = @{@"XRP":@"GBVOL67TMUQBGL4TZYNMY3ZQ5WGQYFPFD5VJRWXR72VA33VFNL225PL5",
                               @"TERN":@"GDGQDVO6XPFSY4NMX75A7AOVYCF5JYGW2SHCJJNWCQWIDGOZB53DGP6C",
                               @"SHX":@"GDSTRSHXHGJ7ZIVRBXEYE5Q74XUVCUSEKEBR7UCHEUUEK72N7I7KJ6JH",
                               @"RMT":@"GDEGOXPCHXWFYY234D2YZSPEJ24BX42ESJNVHY5H7TWWQSYRN5ZKZE3N",
                               @"LTC":@"GC5LOR3BK6KIOK7GKAUD5EGHQCMFOGHJTC7I3ELB66PTDFXORC2VM5LP",
                               @"CNY":@"GAREELUB43IRHWEASCFBLKHURCGMHE5IF6XSE7EXDLACYHGRHM43RFOX",
                               @"BTC":@"GBSTRH4QOTWNSVA6E4HFERETX4ZLSR3CIUBLK7AXYII277PFJC4BBYOG",
                               @"USD":@"GBSTRUSD7IRX73RQZBL3RQUH6KS3O4NYFY3QCALDLZD77XMZOPWAVTUK",
                               @"ETH":@"GBSTRH4QOTWNSVA6E4HFERETX4ZLSR3CIUBLK7AXYII277PFJC4BBYOG"
                                };
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    APIManager *manager = [[APIManager alloc]init];
    [manager getPriceForKey:@"XLM" withCompletion:^(NSString *price){
        dispatch_async(dispatch_get_main_queue(), ^{
        self.cryptoPriceLabel.text = price;
            });
    }];
    
//    [manager getAccountInformationForAccount:@"GBPWNPVEHGWYO3PHD6SV3NYPTYX6FCQLKSY7BZLOKOOOBT22ZH73VLAX" withCompletion:^(NSDictionary *info){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"%@",[info objectForKey:@"balances"]);
//
//
//        });
//    }];
    
    [manager getAssetsWithIssuers:(self.currencyDictionary) withCompletion:^(NSDictionary *info){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",info);
            
            
        });
    }];
    
    
    
}


@end

