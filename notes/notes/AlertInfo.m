//
//  AlertInfo.m
//  notes
//
//  Created by Pedro Ramos on 7/3/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

#import "AlertInfo.h"

@implementation AlertInfo
-(id)initWithTitle: (NSString*)titulo message:(NSString*)m{
    self= [super init];
    self.titulo=titulo;
    self.m=m;
    return self;
}
@end
