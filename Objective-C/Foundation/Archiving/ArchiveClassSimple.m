@interface ArchiveClassSimple : NSObject
{
    int integer;
    NSString *string;
}
+ new;
- initWithString:(NSString *)theString andInteger:(int)theInteger;
@end

@implementation ArchiveClassSimple
+ new 
{
    return OOB_AUTORELEASE([[self alloc] init]);
}

- init
{
    [super init];
    return [self initWithString:@"archiveTest" andInteger:23];
}

- initWithString:(NSString *)theString andInteger:(int)theInteger
{
    string = theString;
    integer = theInteger;
    return self;
}

- (int)integer 
{
    return integer;
}

- (NSString *)string
{
    return string;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:string];
    [coder encodeValueOfObjCType:@encode(typeof(integer)) at:&integer];
}

- initWithCoder:(NSCoder *)decoder
{
    string = [decoder decodeObject];
    [decoder decodeValueOfObjCType:@encode(typeof(integer)) at:&integer];
    return self;
}
@end
