package com.study.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @author tao
 * @create 2021-07-28 10:24
 * @Description 用来返回json数据的通用类
 */
public class Msg {

    // 状态码 100成功 200失败
    private int code;
    // 提示信息
    private String msg;
    // 用户要返回给浏览器的数据
    private Map<String,Object> extend = new HashMap<String, Object>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理成功");
        return msg;
    }
    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理失败");
        return msg;
    }

    // 处理链式调用
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
