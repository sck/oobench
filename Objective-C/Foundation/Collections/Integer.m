@interface Integer : NSObject
{
    long _value;
}
+ (Integer *)integerWithLong:(long)value;
- (Integer *)initWithLong:(long)value;
- (Integer *)setLongValue:(long)value;
- (long)longValue;
- (NSComparisonResult)compare:other;
- (unsigned)hash;
@end

@implementation Integer
+ (Integer *)integerWithLong:(long)value
{
    return OOB_AUTORELEASE([[self alloc] initWithLong:value]);
}

- (Integer *)initWithLong:(long)value
{
    _value = value;
    return self;
}

- (Integer *)setLongValue:(long)value
{
    _value = value;
    return self;
}

- (long)longValue
{
    return _value;
}

- (NSComparisonResult)compare:other
{
    long selfInt = [self longValue];
    long otherInt = [other longValue];

    if (otherInt < selfInt) {
        return NSOrderedAscending;
    }
    if (otherInt > selfInt) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

- (unsigned)hash
{
    return (unsigned)_value;
}
@end
