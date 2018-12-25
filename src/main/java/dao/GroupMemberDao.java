package dao;

import entity.GroupMember;
import entity.Student;

import java.util.List;

public interface GroupMemberDao extends BaseDao<GroupMember>{
    List<GroupMember> findbyuserid(Student student);
}
