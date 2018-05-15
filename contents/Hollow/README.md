# 项目中平常遇到的坑

---

## 一、文本计算的坑

### 1、存在的问题

理论上设置 `View` 的大小，最好预先设置好，尽量不要计算。但是项目中，很多时候需要先计算出文本在某字体下的宽高，再设置 `view` 的 `frame`。有时候文本计算得到的 `width` 和 `height` 是小数，如 16.48、15.32。如果直接使用，必然会造成像素不对齐的问题(因为 16.48、15.32 乘以 2 或 3 得到的都不是整数)。

### 2、解决办法

在项目扩展了 `NSString` 方法，使用新增的方法统一计算文本的大小，在这些方法中使用 `ceil()` 将小数点后数据除去，使得计算的结果小数点后都是0。


```
/// 单行的
- (CGSize)textSizeWithFont:(UIFont *)font {

   CGSize textSize = [self sizeWithAttributes:@{NSFontAttributeName:font}];
   textSize = CGSizeMake((int)ceil(textSize.width), (int)ceil(textSize.height));
   return textSize;
}

/// 根据字体、行数、行间距和constrainedWidth计算多行文本占据的size
- (CGSize)textSizeWithFont:(UIFont *)font
                numberOfLines:(NSInteger)numberOfLines
                  lineSpacing:(CGFloat)lineSpacing
             constrainedWidth:(CGFloat)constrainedWidth
            isLimitedToLines:(BOOL *)isLimitedToLines {

    if (self.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [self boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;

    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    } else {
        if (rows > numberOfLines) {
            rows = numberOfLines;
            if (isLimitedToLines) {
                *isLimitedToLines = YES;  //被限制
            }
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }

    return CGSizeMake(ceil(constrainedWidth),ceil(realHeight));
}
```

## 二、UITableview的header和footer高度的坑

### 1、存在的问题

项目中使用 `Group Style` 的 `UITableview`，为了避免让系统去设置 `header` 或者 `footer` 的高度，我们自己去设置 `tableView:heightForHeaderInSection:` 和 `tableView:heightForFooterInSection` 的值，早前做法是直接将其返回 0.01f ，达到隐藏 `header` 和 `footer` 的效果，但是这么做是会造成像素不对齐。

### 2、解决办法

使用尽可能下的数值，0.01 还不够小，直接使用系统提供的 `CGFLOAT_MIN` 吧。

```
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

```

注意：在设置 `UITableViewCell` 的高度时候，使用的浮点数，小数点后不可以有 0 的数，否则造成像素不对齐。
