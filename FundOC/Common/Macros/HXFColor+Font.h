//
//  HXFColor+Font.h
//  HXFund
//
//  Created by D on 2019/5/28.
//  Copyright © 2019 D. All rights reserved.
//

#ifndef HXFColor_Font_h
#define HXFColor_Font_h

#import "UIColor+HXFTool.h"
#import "UIColor+HXFNSStringTool.h"

#define RGB(R,G,B)                 [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:1.0f]

#define RGBA(R,G,B,A)              [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

#define HEF_COLOR_HEX(exp)         [UIColor colorWithHexString:exp]

#endif /* HXFColor_Font_h */
