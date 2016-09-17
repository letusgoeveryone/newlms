package cn.edu.henu.rjxy.lms.model;
// Generated 2015-10-23 19:30:46 by Hibernate Tools 4.3.1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;



@Entity(name = "key_Value")
public class KeyValue  implements java.io.Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer kvId;
    @Column(name = "mykey", length= 32, unique = true)
    private String mykey;
    @Column(name = "myvalue", length = 1024)
    private String myvalue;

    public KeyValue() {
    }

    public KeyValue(String mykey, String myvalue) {
        this.mykey = mykey;
        this.myvalue = myvalue;
    }

    /**
     * @return the kvId
     */
    public Integer getKvId() {
        return kvId;
    }

    /**
     * @param kvId the kvId to set
     */
    public void setKvId(Integer kvId) {
        this.kvId = kvId;
    }

    /**
     * @return the mykey
     */
    public String getMykey() {
        return mykey;
    }

    /**
     * @param mykey the mykey to set
     */
    public void setMykey(String mykey) {
        this.mykey = mykey;
    }

    /**
     * @return the myvalue
     */
    public String getMyvalue() {
        return myvalue;
    }

    /**
     * @param myvalue the myvalue to set
     */
    public void setMyvalue(String myvalue) {
        this.myvalue = myvalue;
    }
    
    
    

}


