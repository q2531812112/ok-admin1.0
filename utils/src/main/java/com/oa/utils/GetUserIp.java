package com.oa.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * @description:
 * @author: MagicXianyu
 * @date: 2020-06-17 12:43
 */
public class GetUserIp {
    public static String getLocalIPForCMD(){
        StringBuilder sb = new StringBuilder();
        String command = "cmd.exe /c ipconfig | findstr IPv4"; 		// 管道命令
        try {
            Process p = Runtime.getRuntime().exec(command); 		// 执行命令
            BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream())); // 包装缓冲输入流
            String line = null;
            while((line = br.readLine()) != null){					//循环读取
                line = line.substring(line.lastIndexOf(":")+2,line.length()); //截取IPV4地址
                sb.append(line);
            }
            br.close();  					// 字符流关闭
            p.destroy(); 					// 进程销毁
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb.toString(); 				// 返回IPV4地址
    }
}
