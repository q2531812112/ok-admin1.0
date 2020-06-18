package com.oa.controller;

import com.github.pagehelper.Page;
import com.oa.vo.PageUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-17 15:42
 */
@Controller
@RequestMapping("/utils")
public class UtilsController  {

    //文件上传的指定项目的路径，非Target路径
    private static final String UPLOADPICTURE_PATH = "D:\\JAVA\\ideaProject\\oa\\web\\src\\main\\webapp\\imgs\\portrait\\";

    /**
     * 文件上传，一定要配置文件上传解析器，可以在Spring里配置也可以在web.xml内配置,Multipart解析器
     * @param file
     * @param pageUtil
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadPicture",method = {RequestMethod.POST})
    public @ResponseBody PageUtil uploadPicture(@RequestParam(value = "file",required=false) MultipartFile file, PageUtil pageUtil, HttpServletRequest request) throws IOException {
        System.out.println("文件开始准备上传......");
        String path = request.getServletContext().getRealPath("");
        //上传文件名
        String name = file.getOriginalFilename();//上传文件的真实名称
        String suffixName = name.substring(name.lastIndexOf("."));//获取后缀名
        String hash = Integer.toHexString(new Random().nextInt());//自定义随机数（字母+数字）作为文件名
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
        String yearMonth = format.format(date);
        format = new SimpleDateFormat("dd-HH-mm-ss-");
        String day = format.format(date);
        String fileName = "imgs/portrait/" + yearMonth + "/" + day + hash + suffixName;
        File filepath = new File(path, fileName);
        System.out.println("文件路径名称"+fileName);
        //判断路径是否存在，没有就创建一个
        if (!filepath.getParentFile().exists()) {
            filepath.getParentFile().mkdirs();
        }
        //将上传文件保存到一个目标文档中
        File tempFile = new File(path + File.separator + fileName);
        file.transferTo(tempFile);
        pageUtil.setCode(0);
        pageUtil.setMsg(fileName);
        return pageUtil;
    }

}
