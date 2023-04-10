# 华为麒麟710内核  
实验性质项目。  
目的：修改内核达到兼容/移植KernelSU。    

## Changlog:
1. 2023.04.10 删除华为间谍和SELinux监视。
2. 2023.04.11 增加KernelSU，开启KPROBES，关闭CONFIG_HISI_PMALLOC。[注：1]
3. 2023.04.11 关闭AVB验证
4. 2023.04.11 完全移植KernelSU[注：2]


#### 注
+ 注1 
  >` ../include/linux/pmalloc.h: In function ‘pzalloc’:
../include/linux/pmalloc.h:109:35: error: ‘__GFP_ZERO’ undeclared (first use in this function)
  return pmalloc(pool, size, gfp | __GFP_ZERO); `  
  > include/linux/pmalloc.h 文件调用编译，但是已经无需此功能，
  > 在此文件开头可以看到定义：`#ifdef CONFIG_HISI_PMALLOC`
  > 所以在defconfig内直接关闭即可。
+ 注2
  > 参见[commit](https://github.com/Coconutat/android_kernel_huawei_kirin710/commit/6936691270efda2163c9b92357c907ef5c52e981)



# 研究贡献者： 
 + [麦麦观饭](https://github.com/maimaiguanfan) / [麒麟盘古内核](https://github.com/maimaiguanfan/android_kernel_huawei_hi3660/)：提供了内核参考研究。 
 + [kindle4jerry](https://github.com/kindle4jerry) : 感谢大佬的建议和无私帮助。   
 + [术哥](https://github.com/tiann) / [KernelSU](https://github.com/tiann)：开发了牛逼闪闪的各种炫酷东东的大佬。没有他就没有KernelSU。感谢他在我折腾华为内核期间给予的帮助。 