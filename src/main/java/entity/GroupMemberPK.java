package entity;

import java.io.Serializable;
import java.util.Objects;

public class GroupMemberPK implements Serializable {
    private String gm_gr_id;//小组id
    private  String gm_st_id;//学生成员ID


    public String getGm_gr_id() {
        return gm_gr_id;
    }

    public void setGm_gr_id(String gm_gr_id) {
        this.gm_gr_id = gm_gr_id;
    }

    public String getGm_st_id() {
        return gm_st_id;
    }

    public void setGm_st_id(String gm_st_id) {
        this.gm_st_id = gm_st_id;
    }



    @Override
    public boolean equals(Object o){
        if(o instanceof  GroupMemberPK){
            GroupMemberPK pk = (GroupMemberPK) o;
            if(this.gm_gr_id.equals(pk.getGm_gr_id()) &&
                    this.gm_st_id.equals(pk.getGm_st_id())){
                return true;
            }
        }

        return false;
    }
    @Override
    public int hashCode() {
        return Objects.hash(gm_gr_id,gm_st_id);
    }

}
