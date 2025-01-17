// Copyright 2015-present 650 Industries. All rights reserved.

#import <Foundation/Foundation.h>
#import <ABI44_0_0ExpoModulesCore/ABI44_0_0EXFontProcessorInterface.h>
#import <ABI44_0_0EXFont/ABI44_0_0EXFontManager.h>

@interface ABI44_0_0EXFontLoaderProcessor : NSObject <ABI44_0_0EXFontProcessorInterface>

- (instancetype)initWithFontFamilyPrefix:(NSString *)prefix
                                 manager:(ABI44_0_0EXFontManager *)manager;

- (instancetype)initWithManager:(ABI44_0_0EXFontManager *)manager;

@end
