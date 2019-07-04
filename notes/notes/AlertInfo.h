//
//  AlertInfo.h
//  notes
//
//  Created by Pedro Ramos on 7/3/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertInfo : NSObject
-(id)initWithTitle: (NSString*)titulo message:(NSString*)m;
@property(strong)NSString* titulo;
@property NSString* m;
@end

NS_ASSUME_NONNULL_END
