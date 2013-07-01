package sri.score.common


public class Constants {
    //用户类型，目前版本以此来判断权限
    public static final int USERTYPES_NORMAL = 1 << 0
    public static final int USERTYPES_APPROVER = 1 << 1
    public static final int USERTYPES_ADMINISTRATOR = 1 << 2

    public static final int PROJECTTYPES_STATIC = 1
    public static final int PROJECTTYPES_TASK = 2
    public static final int PROJECTTYPES_LEVEL = 3
    public static final int PROJECTTYPES_CUSTOM = 4


    public static final int PROJECTSTATUS_OUTSTANDING = 1 << 0   //未处理
    public static final int PROJECTSTATUS_APPROVED = 1 << 1             //已经审批
    public static final int PROJECTSTATUS_FINISHED = 1 << 2                     //已经结束
    public static final int PROJECTSTATUS_SCORED = 1 << 3                         //已经结束
    public static final int PROJECTSTATUS_CANCELED = 1 << 4                           //已经发分


}