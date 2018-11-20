package com.fh.controller.test;

import com.fh.controller.base.BaseController;
import com.fh.service.item.impl.ItemService;
import com.fh.service.management.client.ClientManager;
import com.fh.service.management.interfaceip.InterfaceIPManager;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/rematoget")
public class RematoGetController extends BaseController {

    @Resource(name="interfaceipService")
    private InterfaceIPManager interfaceipService;

    @Resource(name="clientService")
    private ClientManager clientService;

    @Resource(name="itemService")
    ItemService itemService;



    public String getIpAndProjectName()throws Exception{
        String ip = null;
        String projectName = null;
        PageData pd = new PageData();
        pd = interfaceipService.findByNew(pd);
        ip = pd.getString("IP");
        projectName = pd.getString("PROJECTNAME");
        return ip+"/"+projectName;
    }

    @RequestMapping(value="/getCustomer")
    @ResponseBody
    public Map<String, Object> getCustomer() throws Exception{
        Map<String, Object> json = new HashMap<String, Object>();
        String requestUrl = this.getIpAndProjectName()+"/erp_get/erp_cus";
        //调用方式  0为远程接口方式，1为多数据源调用方式
        String todoType = Tools.readTxtFile("admin/config/TYPE.txt");
        JSONArray jsonarr = null;
        try {
            if(todoType.equals("0")){
                //执行接口调用
                jsonarr = this.executeInter(requestUrl,"GET");
            }else {
                //多数据源连接，erp数据库
                List<PageData> jsonlist = null;  //null换成service查询数据
                jsonarr = JSONArray.fromObject(jsonlist);
            }
            System.out.println(jsonarr.size());
            PageData pd = new PageData();
            //查询本地数据
            List<PageData> varOList = clientService.listAll(pd);  //本地数据
            //新增开关
            int hint = 0; //1为开启，0为关闭
            //删除开关
            int dint = 0; //开1,关0
            //int dstr = 0;
            int count = 0;
            int dcount = 0;
            int ecount = 0;
            PageData pd3 = new PageData();
            if(jsonarr.size() > 0 ){
                for (int i = 0; i < jsonarr.size(); i++) {
                    hint = 1;
                    JSONObject job = jsonarr.getJSONObject(i);
                    if (varOList.size() > 0){
                        for (int j = 0; j < varOList.size(); j++) {
                            //判断本地数据和erp数据是否已经存在FITEMID
                            if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
                                //存在即把开关关闭
                                hint = 0;
                                //判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
                                if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
                                    pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
                                    pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
                                    pd3.put("FNAME", job.getString("FName"));
                                    pd3.put("FNUMBER", job.getString("FNumber"));
                                    pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                                    pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                                    pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                                    //执行修改（找到对应的service）
                                    //clientService.edit(pd3);
                                    ecount ++ ;
                                }
                            }
                        }
                    }
                    //如果上面没有把开关关闭，即执行保存
                    if(hint == 1) {
                        pd.put("CLIENT_ID", this.get32UUID());
                        pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
                        pd.put("FNAME", job.getString("FName"));
                        pd.put("FNUMBER", job.getString("FNumber"));
                        pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                        pd.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                        pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                        //执行保存（找到对应的service）
                        clientService.save(pd);
                        count++;
                    }
                }
            }
            //在这里做一次嵌套for循环，必须分开做，反向判断
            PageData pd2 = new PageData();
            if(varOList.size() > 0){
                for (int j = 0; j < varOList.size(); j++) {
                    dint = 1;  //初始化开关
                    if(jsonarr.size() > 0){
                        for (int i = 0; i < jsonarr.size(); i++) {
                            JSONObject job = jsonarr.getJSONObject(i);
                            if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
                                dint = 0; //erp存在改数据，关闭删除
                            }
                        }
                        //当没有检查到erp存在对应FITEMID的话，关闭删除没有设定，执行删除
                        if(dint == 1){
                            pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
                            clientService.deleteByFITEMID(pd2);
                            dcount ++ ;
                        }
                    }else {
                        //逻辑全部删除
                    }
                }
            }
            System.out.println("=====数据处理完成=====");
            System.out.println("新增数据"+count);
            System.out.println("修改数据"+ecount);
            System.out.println("删除数据"+dcount);
            json.put("Data", "新增数据"+count+"条；"+"修改数据"+ecount+"条；"+"删除数据"+dcount+"条。");
            System.gc();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    public JSONArray executeInter(String url,String type){
        JSONArray jsonarr = null;
        try {
            URL httpclient =new URL(url);
            HttpURLConnection conn =(HttpURLConnection) httpclient.openConnection();
            conn.setConnectTimeout(50000);
            conn.setReadTimeout(20000);
            conn.setRequestMethod(type);
            conn.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.connect();
            InputStream is =conn.getInputStream();
            //int size =is.available();
            ByteArrayOutputStream buff = new ByteArrayOutputStream();
            int c;
            while((c = is.read()) >= 0){
                buff.write(c);
            }
            byte[] data = buff.toByteArray();
            buff.close();

            String htmlText = new String(data, "UTF-8");
            JSONObject jsStr = JSONObject.fromObject(htmlText);
            jsonarr = jsStr.getJSONArray("Data"); // erp数据
        }catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonarr;
    }

    @RequestMapping(value="/test")
    @ResponseBody
    public Map<String, Object> test() throws Exception{
        Map<String, Object> json = new HashMap<String, Object>();
        String requestUrl = this.getIpAndProjectName()+"/erp_get/erp_cus";
        //调用方式  0为远程接口方式，1为多数据源调用方式
        String todoType = Tools.readTxtFile("admin/config/TYPE.txt");
        JSONArray jsonarr = null;
        //System.out.println(DateUtil.getDateTimeStr());
        try {
            PageData pd = new PageData();
            //多数据源连接，erp数据库
            List<PageData> jsonlist = itemService.listClient(pd);  //null换成service查询数据
            jsonarr = JSONArray.fromObject(jsonlist);
            //查询本地数据
            List<PageData> varOList = clientService.listAll(pd);  //本地数据
            System.out.println(varOList.size());
            //新增开关
            int hint = 0; //1为开启，0为关闭
            //删除开关
            int dint = 0; //开1,关0
            //int dstr = 0;
            int count = 0;
            int dcount = 0;
            int ecount = 0;
            PageData pd3 = new PageData();
            //System.out.println(DateUtil.getDateTimeStr());
            if(jsonarr.size() > 0 ){
                for (int i = 0; i < jsonarr.size(); i++) {
                    hint = 1;
                    JSONObject job = jsonarr.getJSONObject(i);
                    if (varOList.size() > 0){
                        for (int j = 0; j < varOList.size(); j++) {
                            //判断本地数据和erp数据是否已经存在FITEMID
                            if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
                                //存在即把开关关闭
                                hint = 0;
                                //判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
                                if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
                                    pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
                                    pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
                                    pd3.put("FNAME", job.getString("FName"));
                                    pd3.put("FNUMBER", job.getString("FNumber"));
                                    pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                                    pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                                    pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                                    //执行修改（找到对应的service）
                                    //clientService.edit(pd3);
                                    ecount ++ ;
                                }
                            }
                        }
                    }
                    //如果上面没有把开关关闭，即执行保存
                    if(hint == 1) {
                        pd.put("CLIENT_ID", this.get32UUID());
                        pd.put("FMODIFYTIME", job.get("FModifyTime").toString());
                        pd.put("FNAME", job.getString("FName"));
                        pd.put("FNUMBER", job.getString("FNumber"));
                        pd.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                        pd.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                        pd.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                        //执行保存（找到对应的service）
                        clientService.save(pd);
                        count++;
                    }
                }
            }
            //System.out.println(DateUtil.getDateTimeStr());
            //在这里做一次嵌套for循环，必须分开做，反向判断
            PageData pd2 = new PageData();
            if(varOList.size() > 0){
                for (int j = 0; j < varOList.size(); j++) {
                    dint = 1;  //初始化开关
                    if(jsonarr.size() > 0){
                        for (int i = 0; i < jsonarr.size(); i++) {
                            JSONObject job = jsonarr.getJSONObject(i);
                            if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
                                dint = 0; //erp存在改数据，关闭删除
                            }
                        }
                        //当没有检查到erp存在对应FITEMID的话，关闭删除没有设定，执行删除
                        if(dint == 1){
                            pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
                            clientService.deleteByFITEMID(pd2);
                            dcount ++ ;
                        }
                    }else {
                        //逻辑全部删除
                    }
                }
            }
            System.out.println("=====数据处理完成=====");
            System.out.println("新增数据"+count);
            System.out.println("修改数据"+ecount);
            System.out.println("删除数据"+dcount);
            json.put("Data", "新增数据"+count+"条；"+"修改数据"+ecount+"条；"+"删除数据"+dcount+"条。");
            //System.out.println(DateUtil.getDateTimeStr());
            System.gc();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @RequestMapping(value="/batchInsert")
    @ResponseBody
    public Map<String, Object> batchInsert() throws Exception{
        Map<String, Object> json = new HashMap<String, Object>();
        String requestUrl = this.getIpAndProjectName()+"/erp_get/erp_cus";
        //调用方式  0为远程接口方式，1为多数据源调用方式
        String todoType = Tools.readTxtFile("admin/config/TYPE.txt");
        JSONArray jsonarr = null;
        //System.out.println(DateUtil.getDateTimeStr());
        try {
            PageData pd = new PageData();
            if(todoType.equals("0")){
                //执行接口调用
                jsonarr = this.executeInter(requestUrl,"GET");
            }else {
                //多数据源连接，erp数据库
                List<PageData> jsonlist = itemService.listClient(pd);  //null换成service查询数据
                jsonarr = JSONArray.fromObject(jsonlist);
            }
            //查询本地数据
            List<PageData> varOList = clientService.listAll(pd);  //本地数据
            //新增开关
            int hint = 0; //1为开启，0为关闭
            //删除开关
            int dint = 0; //开1,关0
            //int dstr = 0;
            int count = 0;
            int dcount = 0;
            int ecount = 0;
            StringBuffer strbuf = new StringBuffer();
            JSONObject job = null;
            PageData pd3 = new PageData();
            List<PageData> strlist = new ArrayList<PageData>();
            if(jsonarr.size() > 0 ){
                int num = 100; //设置每次100条
                int remainder = jsonarr.size() % num;  //取到余数
                int numcount = jsonarr.size() / num;  //次数
                for (int x = 0; x < numcount; x++) {
                    strlist.clear();
                    for (int i = num * x; i < num * (x + 1); i++) {
                        hint = 1;
                        job = jsonarr.getJSONObject(i);
                        if (varOList.size() > 0){
                            for (int j = 0; j < varOList.size(); j++) {
                                //判断本地数据和erp数据是否已经存在FITEMID
                                if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
                                    //存在即把开关关闭
                                    hint = 0;
                                    //判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
                                    if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
                                        pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
                                        pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
                                        pd3.put("FNAME", job.getString("FName"));
                                        pd3.put("FNUMBER", job.getString("FNumber"));
                                        pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                                        pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                                        pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                                        //执行修改（找到对应的service）
                                        clientService.edit(pd3);
                                        ecount ++ ;
                                    }
                                }
                            }
                        }
                        //如果上面没有把开关关闭，即执行保存
                        if(hint == 1) {
                            PageData pdCus = new PageData();
                            pdCus.put("CLIENT_ID", this.get32UUID());
                            pdCus.put("FMODIFYTIME", job.get("FModifyTime").toString());
                            pdCus.put("FNAME", job.getString("FName"));
                            pdCus.put("FNUMBER", job.getString("FNumber"));
                            pdCus.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                            pdCus.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                            pdCus.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                            strlist.add(pdCus);
                            count++;
                        }
                    }
                    //System.out.println(strlist);
                    if(strlist.size() > 0){
                        clientService.saveByList(strlist);
                    }
                }
                strlist.clear();
                for (int i = (jsonarr.size() - remainder); i < jsonarr.size(); i++) {
                    hint = 1;
                    job = jsonarr.getJSONObject(i);
                    if (varOList.size() > 0){
                        for (int j = 0; j < varOList.size(); j++) {
                            //判断本地数据和erp数据是否已经存在FITEMID
                            if(varOList.get(j).get("FITEMID").equals(Integer.parseInt(job.get("FItemID").toString()))){
                                //存在即把开关关闭
                                hint = 0;
                                //判断本地数据和erp的FMODIFYTIME和本地FMODIFYTIME是否相等，如果不相等即进行修改
                                if (!varOList.get(j).get("FMODIFYTIME").equals(job.get("FModifyTime").toString())) {
                                    pd3.put("CLIENT_ID", varOList.get(j).get("CLIENT_ID"));
                                    pd3.put("FMODIFYTIME", job.get("FModifyTime").toString());
                                    pd3.put("FNAME", job.getString("FName"));
                                    pd3.put("FNUMBER", job.getString("FNumber"));
                                    pd3.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                                    pd3.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                                    pd3.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                                    //执行修改（找到对应的service）
                                    clientService.edit(pd3);
                                    ecount ++ ;
                                }
                            }
                        }
                    }
                    //如果上面没有把开关关闭，即执行保存
                    if(hint == 1) {
                        PageData pdCus = new PageData();
                        pdCus.put("CLIENT_ID", this.get32UUID());
                        pdCus.put("FMODIFYTIME", job.get("FModifyTime").toString());
                        pdCus.put("FNAME", job.getString("FName"));
                        pdCus.put("FNUMBER", job.getString("FNumber"));
                        pdCus.put("FITEMID", Integer.parseInt(job.get("FItemID").toString()));
                        pdCus.put("FDELETED", Integer.parseInt(job.get("FDeleted").toString()));
                        pdCus.put("FPARENTID", Integer.parseInt(job.get("FParentID").toString()));
                        strlist.add(pdCus);
                        count++;
                    }
                }
                //System.out.println(strlist);
                if(strlist.size() > 0){
                    clientService.saveByList(strlist);
                }
            }
            //在这里做一次嵌套for循环，必须分开做，反向判断
            PageData pd2 = new PageData();
            if(varOList.size() > 0){
                for (int j = 0; j < varOList.size(); j++) {
                    dint = 1;  //初始化开关
                    if(jsonarr.size() > 0){
                        for (int i = 0; i < jsonarr.size(); i++) {
                            job = jsonarr.getJSONObject(i);
                            if(Integer.parseInt(job.get("FItemID").toString()) == Integer.parseInt(varOList.get(j).get("FITEMID").toString())){
                                dint = 0; //erp存在改数据，关闭删除
                            }
                        }
                        //当没有检查到erp存在对应FITEMID的话，关闭删除没有设定，执行删除
                        if(dint == 1){
                            pd2.put("FITEMID",Integer.parseInt(varOList.get(j).get("FITEMID").toString()));
                            clientService.deleteByFITEMID(pd2);
                            dcount ++ ;
                        }
                    }else {
                        //逻辑全部删除
                    }
                }
            }
            System.out.println("=====数据处理完成=====");
            System.out.println("新增数据"+count);
            System.out.println("修改数据"+ecount);
            System.out.println("删除数据"+dcount);
            json.put("Data", "新增数据"+count+"条；"+"修改数据"+ecount+"条；"+"删除数据"+dcount+"条。");
            //System.out.println(DateUtil.getDateTimeStr());
            System.gc();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json;
    }

    @Test
    public void type(){
        String str= "!1111";
        Integer i = 1111;
        System.out.println(str.getClass());
        System.out.println(i.getClass());
        System.out.println(t(str));
    }

    public String t(Object i){
        String te = null;
        if(i instanceof Integer){
            te = "1";
        }else if(i instanceof String){
            te = "2";
        }
        return te;
    }
}
