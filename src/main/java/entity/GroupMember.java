package entity;

public class GroupMember {
    private Integer valid;

    GroupMemberPK groupMemberPK;

    private  Group group;

    private Student student;

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Integer getValid() {
        return valid;
    }

    public void setValid(Integer valid) {
        this.valid = valid;
    }



    public GroupMemberPK getGroupMemberPK() {
        return groupMemberPK;
    }

    public void setGroupMemberPK(GroupMemberPK groupMemberPK) {
        this.groupMemberPK = groupMemberPK;
    }


}
