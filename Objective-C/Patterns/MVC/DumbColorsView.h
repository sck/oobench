@interface DumbColorsView : View
{
    NSString *name;
    unsigned long drawCount;
}
+ viewWithModel:(Model *)aModel andName:(const char *)aName;
- initWithModel:(Model *)aModel andName:(const char *)aName;
- (unsigned long)drawCount;
@end
