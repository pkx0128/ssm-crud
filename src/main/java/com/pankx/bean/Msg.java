package com.pankx.bean;

import java.util.HashMap;
import java.util.Map;

/**
 *通用的返回信息类
 */
public class Msg {
    //状态码
    private int code;
    //提示信息
    private String msg;
    //用户要返回给浏览器的数据
    Map<String,Object> extend = new HashMap<String,Object>();

    public static Msg success(){
        Msg rel = new Msg();
        rel.setCode(100);
        rel.setMsg("处理成功");
        return rel;
    }

    public static Msg fail(){
        Msg rel = new Msg();
        rel.setCode(200);
        rel.setMsg("处理失败");
        return rel;
    }

    public Msg add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
