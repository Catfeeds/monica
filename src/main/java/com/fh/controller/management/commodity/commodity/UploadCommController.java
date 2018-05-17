package com.fh.controller.management.commodity.commodity;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fh.service.commodity.commoditypic.CommodityPicManager;

@SuppressWarnings("serial")
@Controller
@RequestMapping(value="/commodityUp")
public class UploadCommController extends HttpServlet{
	
	@Resource(name="commoditypicService")
	private CommodityPicManager commoditypicService;
	
	@RequestMapping("/upload")
    @ResponseBody
    public Map<String, Object> updatePhoto(HttpServletRequest request,HttpServletResponse response,@RequestParam("myFile") MultipartFile myFile){
        Map<String, Object> json = new HashMap<String, Object>();
        try {
            //输出文件后缀名称
            System.out.println(myFile.getOriginalFilename());
            DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            //图片名称
            String name = df.format(new Date());

            Random r = new Random();
            for(int i = 0 ;i<3 ;i++){
                name += r.nextInt(10);
            }
            //
            String ext = FilenameUtils.getExtension(myFile.getOriginalFilename());
            //保存图片       File位置 （全路径）   /upload/fileName.jpg
            String url = request.getSession().getServletContext().getRealPath("/static/images/upload/shop/");
            //相对路径
            String path = "/"+name + "." + ext;
            System.out.println(url+"++++++++++----------------"+path);
            File file = new File(url);
            if(!file.exists()){
                file.mkdirs();
            }
            myFile.transferTo(new File(url+path));
            json.put("success", "/static/images/upload/shop"+path);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json ;
	}
}
